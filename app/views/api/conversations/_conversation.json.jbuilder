json.id conversation.id
json.created_at conversation.formatted_date

json.author do
  json.partial! conversation.author, partial: "api/users/user", as: :user
end

json.receiver do
  json.partial! conversation.receiver, partial: "api/users/user", as: :user
end