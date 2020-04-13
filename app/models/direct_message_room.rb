class DirectMessageRoom < MessageRoom
  validates_with MessageRoom::DirectMessageRoomValidator
end