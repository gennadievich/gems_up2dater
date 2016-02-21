class CreateRubyGems < ActiveRecord::Migration[5.0]
  def change
    create_table :ruby_gems do |t|
      t.string :name
      t.string :description
      t.string :link
      t.integer :version_id
      t.integer :total_downloads

      t.timestamps
    end
  end
end
