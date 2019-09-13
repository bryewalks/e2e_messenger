class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(opts)
    Message.create!({
                      body: opts.fetch('body'),
                      conversation_id: opts.fetch('conversation_id'),
                      user_id: opts.fetch('user_id')
                      })
  end
end
