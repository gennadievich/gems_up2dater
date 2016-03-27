class RubyGem < ApplicationRecord
  has_and_belongs_to_many :projects
  has_many :gem_versions, dependent: :delete_all

  def has_many_versions
    gem_versions.count > 1
  end
end
