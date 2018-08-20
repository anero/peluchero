class ServerImage < ActiveRecord::Base
  has_many :servers

  validates :ami_id, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true

  scope :live, -> { where(archived_at: nil) }

  def archive!
    update_attributes!(archived_at: Time.now)
  end
end
