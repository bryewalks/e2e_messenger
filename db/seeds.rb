require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{name: 'brye', email: 'brye@gmail.com', password: 'password'}, {name: 'jack', email: 'jack@gmail.com', password: 'password'}, {name: 'john', email: 'john@gmail.com', password: 'password'}, {name: 'jay', email: 'jay@gmail.com', password: 'password'}])

Conversation.create([{author_id: '1', receiver_id: '2', password: "password"},{author_id: '1', receiver_id: '3', password: "password"},{author_id: '1', receiver_id: '4', password: "password"},{author_id: '2', receiver_id: '3', password: "password"},{author_id: '2', receiver_id: '4', password: "password"},{author_id: '3', receiver_id: '4', password: "password"}])

# Create back and fourth messages between all users.
user_array = [1,2,3,4]
user_array.each do |user|
  other_users = [1,2,3,4]
  other_users.delete(user)
  3.times do
    receiver = other_users.pop
    conversation = Conversation.where('(author_id = ? AND receiver_id = ?) OR (author_id = ? AND receiver_id = ?)', user, receiver, receiver, user).first
    5.times do 
      message = Message.new(user_id: user, conversation_id: conversation.id, body: Faker::Hacker.say_something_smart)
      message.save
      message = Message.new(user_id: receiver, conversation_id: conversation.id, body: Faker::Hacker.say_something_smart)
      message.save
    end
  end
end

User.create({name: 'phuoc', email: 'phuoc@gmail.com', password: 'password'})
# Conversation.create({author_id: '1', receiver_id: '5', password: "password"})

messages = Message.all
messages.each do |message|
  message.encrypt_body("password")
  message.save
end