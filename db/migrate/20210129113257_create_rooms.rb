class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :proposal_id, null: false
      t.integer :request_id, null: false
      t.datetime :latest_message_created_at

      t.timestamps
      
      t.index :proposal_id
      t.index :request_id
    end
  end
end
