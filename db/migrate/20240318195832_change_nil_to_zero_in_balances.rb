class ChangeNilToZeroInBalances < ActiveRecord::Migration[7.1]
  def change
    change_column_default :deposits, :agree_amount, 0
    change_column_default :members, :balance, 0
    change_column_default :susus, :balance, 0
    Deposit.where(agree_amount: nil).update_all(agree_amount: 0)
    Member.where(balance: nil).update_all(balance: 0)
    Susu.where(balance: nil).update_all(balance: 0)
  end
end
