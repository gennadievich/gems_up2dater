class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :link
      t.integer :user_id

      t.timestamps
    end
  end
end
