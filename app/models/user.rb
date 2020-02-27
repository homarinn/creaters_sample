class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :series
  has_many :novel_series
  has_many :illustration_series
  has_many :comic_series
  has_many :novels
  has_many :illustrations
  has_many :comics
  has_many :message_room_members, dependent: :destroy
  has_many :message_rooms, through: :message_room_members, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one_attached :icon

  validates_with UserValidator
end
