class AddPlayIdToRole < ActiveRecord::Migration
  def change
    add_column :roles, :play_id, :integer
  end
end
