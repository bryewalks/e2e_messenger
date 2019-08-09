json.id conversation.id
json.created_at conversation.formatted_date

json.author do
  json.partial! conversation.get_user(current_user, conversation.author), partial: "api/users/user", as: :user
end

json.receiver do
  json.partial! conversation.get_user(current_user, conversation.receiver), partial: "api/users/user", as: :user
end