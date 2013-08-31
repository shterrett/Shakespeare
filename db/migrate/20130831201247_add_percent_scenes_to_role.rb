class AddPercentScenesToRole < ActiveRecord::Migration
  def change
    add_column :roles, :percent_scenes, :float
  end
end
