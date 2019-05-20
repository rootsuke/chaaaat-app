class RenameFrendRequestToFriendRequest < ActiveRecord::Migration[5.2]
  def change
    rename_table :frend_requests, :friend_requests
  end
end
