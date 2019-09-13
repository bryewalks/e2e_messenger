class MessageCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable
      .server
      .broadcast('message_channel', render_message(message))
  end

  def render_message(message)
    ApplicationController.renderer.render(partial: 'api/messages/message', locals: { message: message })
  end
end