class Server < ActiveRecord::Base
  STATUSES = %w(not_launched launching running stopped terminated)

  belongs_to :server_image

  validates :instance_id, uniqueness: true, allow_blank: true
  validates :status, inclusion: { in: STATUSES }
end
