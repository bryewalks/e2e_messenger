class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates :body, presence: true

  after_create_commit do
    MessageCreationEventBroadcastJob.perform_later(self)
  end

  def current_user?(input_user)
    self.user == input_user
  end
end
