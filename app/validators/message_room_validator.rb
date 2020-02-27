class MessageRoomValidator < DefaultValidator
  def users_validate(users)
    return "ユーザーは2人までです" if @record.class.name == "DirectMessageRoom" && users.size > 2
  end
end