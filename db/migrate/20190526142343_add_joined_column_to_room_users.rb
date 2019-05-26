class AddJoinedColumnToRoomUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :room_users, :joined, :boolean, default: false, null: false
  end
end
