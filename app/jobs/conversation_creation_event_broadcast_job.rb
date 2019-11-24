class ConversationCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(conversation)
    ActionCable
      .server
      .broadcast("user-#{conversation.receiver_id}:conversations", render_conversation(conversation))
    ActionCable
      .server
      .broadcast("user-#{conversation.author_id}:conversations", render_conversation(conversation))
  end

  def render_conversation(conversation)
    ApplicationController.renderer.render(partial: 'api/conversations/conversation', locals: { conversation: conversation, current_user: conversation.author, action: 'created' })
  end
end
