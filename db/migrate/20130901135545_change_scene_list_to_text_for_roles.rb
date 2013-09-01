class ChangeSceneListToTextForRoles < ActiveRecord::Migration
  def change
    change_column :roles, :scene_list, :text
  end
end
