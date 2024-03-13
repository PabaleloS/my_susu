class AddAgreeAmountToSusu < ActiveRecord::Migration[7.1]
  def change
    add_column :susus, :agree_amount, :float
  end
end
