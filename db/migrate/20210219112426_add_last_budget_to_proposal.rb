class AddLastBudgetToProposal < ActiveRecord::Migration[5.2]
  def change
    add_column :proposals, :last_budget, :integer
  end
end
