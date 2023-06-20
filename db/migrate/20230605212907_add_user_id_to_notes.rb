class AddUserIdToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :user_id, :integer
    add_index :notes, :user_id
  end
end
