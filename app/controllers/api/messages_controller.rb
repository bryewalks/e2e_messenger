class Api::MessagesController < ApplicationController
  before_action :set_conversation, only: :index
  before_action :authorize_user, only: :index
  before_action :authenticate_conversation, only: :index

  def index
    @messages = decrypted_messages
    render 'index.json.jbuilder'
  end

  def create
    @message = Message.new(message_params)
    if @message.save!
      render 'show.json.jbuilder'
    else
      render json: {errors: @article.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params
      .require(:message)
      .permit(:body)
      .merge(conversation_id: params[:conversation_id], user_id: current_user.id)
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def decrypted_messages
    @conversation.messages.each{ |message| message.decrypt_body(params[:conversation_password]) }
  end

  def authorize_user
    unless @conversation.receiver_id == current_user.id || @conversation.author_id == current_user.id
      render json: {}, status: :unauthorized
    end 
  end

  def authenticate_conversation
    unless @conversation.authenticate(params[:conversation_password])
      render json: {}, status: :unauthorized
    end
  end
end
