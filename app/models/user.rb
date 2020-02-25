class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :series
  has_many :novels
  has_many :illustrations
  has_many :comics
  has_many :message_room_members
  has_many :message_rooms, through: :message_room_members
  has_many :messages
  has_one_attached :icon
end
