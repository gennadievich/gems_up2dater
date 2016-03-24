class RubyGem < ApplicationRecord
  has_and_belongs_to_many :projects
  has_many :gem_versions, dependent: :delete_all
end
