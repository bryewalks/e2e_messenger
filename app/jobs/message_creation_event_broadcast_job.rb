class MessageCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable
      .server
      .broadcast("conversation-#{message.conversation_id}:messages", render_message(message))
  end

  def render_message(message)
    ApplicationController.renderer.render(partial: 'api/messages/message', locals: { message: message })
  end
end