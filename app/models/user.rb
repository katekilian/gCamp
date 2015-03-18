class User < ActiveRecord::Base

  has_many :memberships
  has_many :projects, through: :memberships
  has_many :comments

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  def full_name
    "#{self.first_name}" + " #{self.last_name}"
  end

end
