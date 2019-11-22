class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user-#{current_user.id}:conversations"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def alert(input_options)
    conversation = Conversation.find(input_options.fetch('id'))
    ConversationCreationEventBroadcastJob.perform_now(conversation)
  end
end
