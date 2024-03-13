class Member < ApplicationRecord
  belongs_to :susu
  belongs_to :user
  has_many :messages

  enum status: ['pending', 'accepted', 'declined']
end
