class ConversationCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(conversation)
    ActionCable
      .server
      .broadcast("user-#{conversation.receiver_id}:conversations", render_conversation(conversation))
  end

  def render_conversation(conversation)
    ApplicationController.renderer.render('api/conversations/websocket', locals: { conversation: conversation })
  end
end
