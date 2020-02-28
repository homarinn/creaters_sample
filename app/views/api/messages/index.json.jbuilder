json.array! @messages do |message|
  json.id message.id
  json.content message.content
  json.created_at message.created_at.strftime("%m/%d %H:%M")
  json.user_name message.user.name
  json.message_room_id message.message_room.id
end