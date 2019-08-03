class Api::MessagesController < ApplicationController
  def index
    @messages = Message.all
    render 'index.json.jbuilder'
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @article.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params
      .require(:message)
      .permit(:conversation_id, :body)
      .merge(user_id: current_user.id)
  end
end
