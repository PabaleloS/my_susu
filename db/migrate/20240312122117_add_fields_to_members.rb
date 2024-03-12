class AddFieldsToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :has_received_disbursement, :boolean, default: false
    add_column :members, :disbursement_date, :date
  end
end
