class Server < ActiveRecord::Base
  belongs_to :server_image

  validates :instance_id, presence: true, uniqueness: true
end
