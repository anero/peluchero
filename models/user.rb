class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, email_format: true, uniqueness: true
end
