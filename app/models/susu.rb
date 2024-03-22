class Susu < ApplicationRecord
  belongs_to :user
  has_many :members
  has_many :deposits
  has_many :users, through: :members
  has_many :messages


  def next_member
    reset_cycle
    members = self.members.where(status: 'accepted').where(has_received_disbursement: false).to_a
    next_member = members.shift

    next_member&.update(has_received_disbursement: true, disbursement_date: Date.today)
    return next_member
  end



  def reset_cycle
    members = self.members.where(status: 'accepted').where(has_received_disbursement: false).to_a

    self.members.update_all(has_received_disbursement: false) if members.empty?
  end

  validates :name, presence: true
  validates :description, presence: true
  validates :agree_amount, presence: true, numericality: { greater_than: 0 }
end
