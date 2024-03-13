class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_susus, class_name: 'Susu'
  has_many :susus, through: :members
  has_many :transactions
  has_many :messages
end
