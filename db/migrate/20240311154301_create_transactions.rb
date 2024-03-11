class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.references :member, null: false, foreign_key: true
      t.float :amount
      t.date :date
      t.references :susu, null: false, foreign_key: true
      t.boolean :is_disbursed

      t.timestamps
    end
  end
end
