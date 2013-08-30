class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :max_speech_length
      t.text :max_speech_text
      t.integer :line_count
      t.string :scene_list
      t.string :name
      t.string :unique_name

      t.timestamps
    end
  end
end
