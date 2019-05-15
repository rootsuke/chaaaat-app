class CreateFrendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :frend_requests do |t|
      t.integer :requester_id
      t.integer :reciever_id
      t.boolean :approved, default: false, null: false

      t.timestamps
    end

    add_index :frend_requests, :requester_id
    add_index :frend_requests, :reciever_id
    add_index :frend_requests, [:requester_id, :reciever_id], unique: true
  end
end
