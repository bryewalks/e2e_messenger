class Api::ConversationsController < ApplicationController
  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    render 'index.json.jbuilder'
  end

  def create
    if Conversation.between(current_user.id,params[:receiver_id]).present?
      @conversation = Conversation.between(current_user.id,params[:receiver_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    render 'show.json.jbuilder'
  end
  
  def show
    @conversation = Conversation.find(params[:id])

    if Conversation.participating(current_user).include?(@conversation)
      render 'show.json.jbuilder'
    else
      render json: {}, status: :unauthorized
    end
  end

  private
  
  def conversation_params
    params
      .require(:conversation)
      .permit(:receiver_id, :password, :password_confirmation)
      .merge(author_id: current_user.id)
  end
end
