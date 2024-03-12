class Message < ApplicationRecord
  belongs_to :susu
  belongs_to :member

  validates :content, presence: true
end
