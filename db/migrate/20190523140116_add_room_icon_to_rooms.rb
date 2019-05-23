class AddRoomIconToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :icon, :string
  end
end
