class CreateSusus < ActiveRecord::Migration[7.1]
  def change
    create_table :susus do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.float :balance

      t.timestamps
    end
  end
end
