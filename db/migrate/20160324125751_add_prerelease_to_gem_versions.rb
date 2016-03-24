class AddPrereleaseToGemVersions < ActiveRecord::Migration[5.0]
  def change
    add_column :gem_versions, :prerelease, :boolean
  end
end
