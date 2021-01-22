class CreateProposals < ActiveRecord::Migration[5.2]
  def change
    create_table :proposals do |t|
      t.integer :user_id, null: false
      t.integer :request_id, null: false
      t.text :text, null: false
      t.integer :status, null: false
      t.integer :budget, null: false 

      t.timestamps
      
      t.index :request_id
      t.index :user_id
    end
  end
end
