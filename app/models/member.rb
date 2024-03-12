class Member < ApplicationRecord
  belongs_to :susu
  belongs_to :user

  enum status: ['pending', 'accepted', 'declined']
end
