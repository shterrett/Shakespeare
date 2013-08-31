class AddSceneCountToRole < ActiveRecord::Migration
  def change
    add_column :roles, :scene_count, :integer
  end
end
