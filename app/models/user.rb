class User < ApplicationRecord
  has_secure_password
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
  has_many :messages, dependent: :destroy 
  validates :name, presence: true, uniqueness: true
end
