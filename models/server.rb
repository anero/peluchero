class Server < ActiveRecord::Base
  class ErrorOnLaunch < StandardError; end;

  STATUSES = %w(pending running shutting-down stopping stopped terminated error_on_launch)
  NOT_TERMINATED_STATUSES = %w(pending running shutting-down stopping stopped)

  belongs_to :server_image
  belongs_to :launched_by, class_name: 'User', foreign_key: 'user_id'
  belongs_to :game

  validates :instance_id, uniqueness: true, allow_blank: true
  validates :status, inclusion: { in: STATUSES }
  validates :terminate_at, presence: true
  validate :terminate_at_must_be_in_future, on: :create

  scope :not_terminated, -> { where('status in (?)', NOT_TERMINATED_STATUSES) }

  def launch!
    begin
      resp = aws_client.run_instances(
        image_id: self.server_image.ami_id,
        security_group_ids: [ self.security_group ],
        instance_type: self.instance_type,
        subnet_id: ENV['AWS_SUBNET'],
        max_count: 1,
        min_count: 1,
        tag_specifications: [
          {
            resource_type: "instance",
            tags: game.tags_for_new_servers,
          },
        ],
      )

      if resp.instances.count == 1
        instance = resp.instances.first
        self.instance_id = instance.instance_id
        self.save!
      end
    rescue StandardError => e
      self.status = 'error_on_launch'
      self.save!
      Padrino.logger.error("Error al lanzar la instancia EC2: #{e.inspect}")
      raise ErrorOnLaunch, e.inspect
    end
  end

  def refresh_status!
    resp = aws_client.describe_instances(instance_ids: [ self.instance_id ])
    if resp.reservations.empty?
      self.status = 'terminated'
    else
      instance_info = resp.reservations[0].instances.first
      self.status = instance_info.state.name
    end

    if terminated?
      self.public_ip = 'N/A'
    else
      self.public_ip = instance_info.network_interfaces[0].association.public_ip
    end

    save!
  end

  def terminate!
    resp = aws_client.terminate_instances(instance_ids: [ self.instance_id ])
  end

  def terminated?
    self.status == 'terminated'
  end

  private

  def aws_client
    @__aws_client ||= Aws::EC2::Client.new(region: ENV['AWS_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']))

    @__aws_client
  end

  def terminate_at_must_be_in_future
    if self.terminate_at.present? && self.terminate_at.utc < Time.now.utc
      errors[:terminate_at] << I18n.t('models.server.errors.terminate_at_must_be_in_future')
    end
  end
end
