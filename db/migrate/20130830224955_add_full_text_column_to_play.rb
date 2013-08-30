class AddFullTextColumnToPlay < ActiveRecord::Migration
  def change
    add_attachment :plays, :full_text
  end
end
