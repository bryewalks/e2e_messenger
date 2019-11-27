class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation-#{params['conversation_id']}:messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(input_message)
    message = Message.new({
                  body: input_message.fetch('body'),
                  conversation_id: params['conversation_id'],
                  user_id: current_user.id})
    message.encrypt_body(params['message_password'])
    message.save
    message.decrypt_body(params['message_password'])
    MessageCreationEventBroadcastJob.perform_now(message)
    ConversationAlertEventBroadcastJob.perform_now(message.conversation, current_user.id)
  end
end
