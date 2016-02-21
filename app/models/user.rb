class User < ApplicationRecord
  belongs_to :role
  has_many :projects

  has_secure_password

  validates_presence_of   :name, :email
  validates_uniqueness_of :email

  def admin?
    role.name == Role::ADMIN
  end
end
