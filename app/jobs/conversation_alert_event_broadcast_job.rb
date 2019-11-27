class ConversationAlertEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(conversation, current_user_id)
    ActionCable
      .server
      .broadcast("user-#{ alert_who(conversation, current_user_id) }:conversations", render_conversation(conversation))
  end

  def render_conversation(conversation)
    ApplicationController.renderer.render('api/conversations/websocket', locals: { conversation: conversation, current_user: conversation.author, action: 'conversation alert' })
  end

  def alert_who(conversation, current_user_id)
    current_user_id == conversation.receiver_id ? conversation.author_id : conversation.receiver_id
  end
end
