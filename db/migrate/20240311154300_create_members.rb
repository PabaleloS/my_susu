class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.references :susu, null: false, foreign_key: true
      t.float :balance
      t.date :join_date
      t.references :user, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
