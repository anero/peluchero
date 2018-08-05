class User < ActiveRecord::Base
  ROLES = %w(unauthorized admin)

  validates :name, presence: true
  validates :email, presence: true, email_format: true, uniqueness: true
  validates :facebook_id, uniqueness: { allow_blank: true }
  validates :role, inclusion: { in: ROLES }

  def self.create_with_omniauth!(auth)
    create! do |user|
      user.facebook_id = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.role = 'unauthorized'
    end
  end
end
