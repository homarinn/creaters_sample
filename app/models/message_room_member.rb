class MessageRoomMember < ApplicationRecord
  belongs_to :user
  belongs_to :message_room
end
