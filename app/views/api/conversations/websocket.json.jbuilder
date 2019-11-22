json.id conversation.id
json.created_at conversation.formatted_date

json.receiver do
  json.id conversation.author.id
  json.name conversation.author.name
end