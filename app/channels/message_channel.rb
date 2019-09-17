class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation-#{params['conversationId']}:messages"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(message)
    Message.create!({
                      body: message.fetch('body'),
                      conversation_id: params['conversationId'],
                      user_id: current_user.id
                    })
  end
end
