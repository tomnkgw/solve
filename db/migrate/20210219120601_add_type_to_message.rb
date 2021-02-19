class AddTypeToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :display_type, :integer, null: false, default: 0
  end
end
