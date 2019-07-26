class User < ApplicationRecord
  has_secure_password
  has_many :messages
  has_many :sent_conversations, class_name: 'Conversation', foreign_key: 'sender_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'recipient_id'
  validates :email, presence: true, uniqueness: true
end
