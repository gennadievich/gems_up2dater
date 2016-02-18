class Role < ApplicationRecord
  has_many :users, dependent: :destroy

  USER  = "user"
  ADMIN = "admin"
end
