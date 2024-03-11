class AddBalanceToSusu < ActiveRecord::Migration[7.1]
  def change
    add_column :susus, :balance, :float
  end
end
