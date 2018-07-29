class Server < ActiveRecord::Base
  belongs_to :server_image

  validates :instance_id, uniqueness: true, allow_blank: true
end
