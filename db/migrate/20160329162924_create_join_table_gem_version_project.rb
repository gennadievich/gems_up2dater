class CreateJoinTableGemVersionProject < ActiveRecord::Migration[5.0]
  def change
    create_join_table :gem_versions, :projects do |t|

    end
  end
end
