class Conversation < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy
  validates :author, uniqueness: {scope: :receiver}
end
