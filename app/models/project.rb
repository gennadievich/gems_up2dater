class Project < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :ruby_gems
end