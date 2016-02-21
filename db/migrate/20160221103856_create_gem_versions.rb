class CreateGemVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :gem_versions do |t|
      t.string :name
      t.date :date
      t.string :latest
      t.integer :this_version_downloads

      t.timestamps
    end
  end
end
