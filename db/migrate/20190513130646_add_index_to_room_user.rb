class AddIndexToRoomUser < ActiveRecord::Migration[5.2]
  def change
    add_index :room_users, [:room_id, :user_id], unique: true
  end
end
