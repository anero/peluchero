# frozen_string_literal: true

class Game < ActiveRecord::Base
  has_many :server_images
  has_many :servers

  validates :name, presence: true, uniqueness: true
  validates :preferred_security_group, presence: true
  validates :tag, presence: true
  validates :server_iam_role, presence: true

  def refresh_status!
    amis = aws_client.describe_images(filters: [{ name: 'tag:game', values: [ self.tag ] }, { name:'tag:managed_by', values: ['peluchero']}]).try(:images) || []
    if amis.any?
      amis.each do |ami|
        existing_server_image = server_images.where(ami_id: ami.image_id).first
        if existing_server_image.nil?
          server_images.create(ami_id: ami.image_id, name: ami.name, description: ami.description)
        elsif existing_server_image.archived_at.present?
          existing_server_image.update_attributes(archived_at: nil)
        end
      end
    end

    # Archive deregistered AMIs
    existing_amis = amis.map(&:image_id)
    server_images
      .reject { |si| existing_amis.include?(si.ami_id) }
      .map(&:archive!)
  end

  def tags_for_new_servers
    [
      { key: 'managed_by', value: 'peluchero' },
      { key: 'game', value: self.tag }
    ]
  end

  private

  def aws_client
    @__aws_client ||= Aws::EC2::Client.new(region: ENV['AWS_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']))
  end
end
