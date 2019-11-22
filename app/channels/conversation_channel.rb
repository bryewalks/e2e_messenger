class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user-#{current_user.id}:conversations"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(input_options)
    conversation = Conversation.new(
                                    author_id: current_user.id,
                                    receiver_id: input_options.fetch('receiver_id'), 
                                    password: input_options.fetch('password'),
                                    password_confirmation: input_options.fetch('password_confirmation')
                                    )
    conversation.save!
    ConversationCreationEventBroadcastJob.perform_now(conversation, current_user)
  end
end
