class AddLineCountAndSceneCountToPlay < ActiveRecord::Migration
  def change
    add_column :plays, :line_count, :integer
    add_column :plays, :scene_count, :integer
  end
end
