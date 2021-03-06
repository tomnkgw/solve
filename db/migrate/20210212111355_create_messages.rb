class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :text, null:false
      t.integer :user_id, null:false
      t.integer :room_id, null:false

      t.timestamps

      t.index :room_id
    end
  end
end
