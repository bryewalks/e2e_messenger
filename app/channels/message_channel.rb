class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation-#{params['conversation_id']}:messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(message)
    new_message = Message.new({
                  body: message.fetch('body'),
                  conversation_id: params['conversation_id'],
                  user_id: current_user.id})
    new_message.encrypt_body(params['message_password'])
    new_message.save
    new_message.decrypt_body(params['message_password'])
    MessageCreationEventBroadcastJob.perform_now(new_message)
  end
end
