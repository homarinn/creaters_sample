class MessageRoom::DirectMessageRoomValidator < DefaultValidator
  def users_validate(users)
    return "ユーザーは2人までです" if users.size > 2
  end
end