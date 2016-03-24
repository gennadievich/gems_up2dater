class AddRubyGemIdToGemVersions < ActiveRecord::Migration[5.0]
  def change
    add_column :gem_versions, :ruby_gem_id, :integer
    add_column :gem_versions, :actual, :boolean
    remove_column :gem_versions, :latest
  end
end
