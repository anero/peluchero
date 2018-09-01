class Game < ActiveRecord::Base
  has_many :server_images
  has_many :servers

  validates :name, presence: true, uniqueness: true
  validates :preferred_security_group, presence: true
  validates :tag, presence: true
end
