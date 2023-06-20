
class AddUserIdToCollections < ActiveRecord::Migration[6.1]
  def change
    add_reference :collections, :user, null: false, foreign_key: true, default: 0
  end

end
