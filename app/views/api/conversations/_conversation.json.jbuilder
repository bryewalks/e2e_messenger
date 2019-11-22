json.id conversation.id
json.created_at conversation.formatted_date
json.unread_messages conversation.unread_messages?(current_user)

json.author do
  json.partial! conversation.get_user(current_user, conversation.author), partial: "api/users/user", as: :user
end

json.receiver do
  json.partial! conversation.get_user(current_user, conversation.receiver), partial: "api/users/user", as: :user
end