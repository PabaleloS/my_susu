class RenameTransactionsToDeposits < ActiveRecord::Migration[7.1]
  def change
    rename_table :transactions, :deposits

    add_column :deposits, :agree_amount, :float
    remove_column :deposits, :is_disbursed
    remove_column :deposits, :type
    remove_column :deposits, :amount
  end
end
