class Transaction < ApplicationRecord
  belongs_to :member
  belongs_to :susu

  validates :amount, presence: true
  validates :date, presence: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
