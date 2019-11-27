json.id conversation.id
json.created_at conversation.formatted_date
json.unread_messages conversation.unread_messages?(current_user)

json.author do
  json.name conversation.author.name
  json.id conversation.author.id
end

json.receiver do
  json.name conversation.receiver.name
  json.id conversation.receiver.id
end