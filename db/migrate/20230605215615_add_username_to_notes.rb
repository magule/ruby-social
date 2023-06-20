class AddUsernameToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :username, :string
    add_index :notes, :username
  end
end
