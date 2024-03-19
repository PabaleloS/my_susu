class Member < ApplicationRecord
  belongs_to :susu
  belongs_to :user
  has_many :deposits, dependent: :destroy
  has_many :messages, dependent: :destroy

  enum status: ['pending', 'accepted', 'declined']
end
