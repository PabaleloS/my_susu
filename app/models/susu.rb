class Susu < ApplicationRecord
  belongs_to :user
  has_many :members

  def next_member
    reset_cycle
    members = self.members.where(status: 'accepted').where(has_received_disbursement: false).to_a
    next_member = members.shift
    next_member.has_received_disbursement = true
    next_member.disbursement_date = Date.today
    next_member.save
    return next_member
  end

  def reset_cycle
    members = self.members.where(status: 'accepted').where(has_received_disbursement: false).to_a

    self.members.update_all(has_received_disbursement: false) if members.empty?
  end
end
