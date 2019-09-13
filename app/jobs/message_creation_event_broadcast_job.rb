class MessageCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable
      .server
      .broadcast('message_channel',
                  id: message.id,
                  name: message.user.name,
                  user: message.user.id,
                  # created_at: message.created_at.strftime('%H:%M'),
                  body: message.body)
  end
end