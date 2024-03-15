class Deposit < ApplicationRecord
  belongs_to :member
  belongs_to :susu

  validates :agree_amount, presence: true
  validates :date, presence: true
  validates :agree_amount, presence: true, numericality: { greater_than: 0 }
end
