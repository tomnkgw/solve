class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.string :title
      t.text :text
      t.string :budget
      t.integer :status

      t.timestamps
    end
  end
end
