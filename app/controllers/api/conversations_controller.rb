class Api::ConversationsController < ApplicationController
  wrap_parameters :conversation, include: [:receiver_id, :password, :password_confirmation]

  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    render 'index.json.jbuilder'
  end

  def create
    @conversation = Conversation.new(conversation_params)
    
    if @conversation.save
      ConversationCreationEventBroadcastJob.perform_now(@conversation)
      render 'show.json.jbuilder'
    end
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
