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

  def create(input_conversation)
    if Conversation.between(current_user.id, input_conversation.fetch('receiver_id')).present?
      conversation = Conversation.between(current_user.id, input_conversation.fetch('receiver_id')).first
    else
      conversation = Conversation.create!(
                                            receiver_id: input_conversation.fetch('receiver_id'),
                                            password: input_conversation.fetch('password'),
                                            password_confirmation: input_conversation.fetch('password_confirmation'),
                                            author_id: current_user.id
                                          )
    end
    ConversationCreationEventBroadcastJob.perform_now(conversation, current_user)
  end
end