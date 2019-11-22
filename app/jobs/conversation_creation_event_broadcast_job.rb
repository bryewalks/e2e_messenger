class ConversationCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(conversation, current_user)
    ActionCable
      .server
      .broadcast("user-#{current_user.id}:conversations", render_conversation(conversation))
  end

  def render_conversation(conversation)
    ApplicationController.renderer.render(partial: 'api/conversations/conversation', locals: { conversation: conversation, current_user: current_user })
    # ApplicationController.renderer.render(partial: 'api/messages/message', locals: { message: message })
  end
end
