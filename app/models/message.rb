class Message < ApplicationRecord
  belongs_to :susu
  belongs_to :member

  validates :content, presence: true


  def sender?(current_user)
    self.member.user == current_user
  end

end
