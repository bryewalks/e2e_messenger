class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates :body, presence: true

  after_create_commit do
    MessageCreationEventBroadcastJob.perform_later(self)
  end
end
