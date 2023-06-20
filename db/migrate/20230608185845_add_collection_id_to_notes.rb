class AddCollectionIdToNotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :notes, :collection, foreign_key: true
  end
end
