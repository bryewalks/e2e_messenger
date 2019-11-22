class Conversation < ApplicationRecord
  has_secure_password
  belongs_to :author, class_name: :User, foreign_key: 'author_id'
  belongs_to :receiver, class_name: :User, foreign_key: 'receiver_id'
  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy
  validates_uniqueness_of :author, :scope => :receiver

  scope :participating, -> (user) do
    where("(conversations.author_id = ? OR conversations.receiver_id = ?)", user.id, user.id)
  end

  scope :between, -> (author_id,receiver_id) do
    where("(conversations.author_id = ? AND conversations.receiver_id =?) OR (conversations.author_id = ? AND conversations.receiver_id =?)", author_id, receiver_id, receiver_id, author_id)
  end

  def formatted_date
    created_at.strftime("%b %d, %Y")
  end

  def get_user(current_user, input_user)
    current_user.id == input_user.id ? author : receiver
  end

  def unread_messages?(current_user)
    last_message = self.messages.where.not("user_id = ?", current_user.id).last
    if last_message
      last_message.read_at == nil
    else
      false
    end
  end
end
