class ServerImage < ActiveRecord::Base
  has_many :servers

  validates :ami_id, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
