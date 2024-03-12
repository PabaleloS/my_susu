class AddBalanceToSusus < ActiveRecord::Migration[6.0]
  def change
    add_column :susus, :balance, :float unless column_exists?(:susus, :balance)
  end
end
