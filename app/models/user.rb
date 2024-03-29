class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_susus, class_name: 'Susu'
  has_many :members, dependent: :destroy
  has_many :susus, through: :members
  has_many :messages
  has_one_attached :photo


  # enum status: ['pending', 'accepted', 'declined']


end
