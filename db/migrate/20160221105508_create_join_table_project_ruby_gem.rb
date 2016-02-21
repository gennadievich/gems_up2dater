class CreateJoinTableProjectRubyGem < ActiveRecord::Migration[5.0]
  def change
    create_join_table :projects, :ruby_gems do |t|
      # t.index [:project_id, :ruby_gem_id]
      # t.index [:ruby_gem_id, :project_id]
    end
  end
end
