class MessageRoom < ApplicationRecord
  has_many :message_room_members, dependent: :destroy
  has_many :users, through: :message_room_members
  has_many :messages, dependent: :destroy
end
