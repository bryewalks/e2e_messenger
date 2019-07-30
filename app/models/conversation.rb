class Conversation < ApplicationRecord
  # before_action :authenticate_user
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy
  validates :author, uniqueness: {scope: :receiver}

  scope :participating, -> (user) do
    where("(conversations.author_id = ? OR conversations.receiver_id = ?)", user.id, user.id)
  end

  def formatted_date
    created_at.strftime("%b %d, %Y")
  end
end
