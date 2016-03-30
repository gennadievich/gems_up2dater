class Project < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :gem_versions

  validates_presence_of :name
end
