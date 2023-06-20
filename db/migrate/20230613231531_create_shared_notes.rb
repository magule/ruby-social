class CreateSharedNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :shared_notes do |t|
      t.references :note, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
