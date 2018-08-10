class Server < ActiveRecord::Base
  STATUSES = %w(pending running shutting-down stopping stopped terminated)

  belongs_to :server_image

  validates :instance_id, uniqueness: true, allow_blank: true
  validates :status, inclusion: { in: STATUSES }

  scope :not_terminated, -> { where('status in (?)', %w(pending running shutting-down stopping stopped)) }

  def refresh_status!
    resp = aws_client.describe_instances(instance_ids: [ self.instance_id ])
    instance_info = resp.reservations[0].instances.first

    self.status = instance_info.state.name

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
end
