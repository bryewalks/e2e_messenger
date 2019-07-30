class Api::ConversationsController < ApplicationController
  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    render 'index.json.jbuilder'
  end

  def create
    @conversation = Conversation.new(conversation_params)

    if @conversation.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @conversation.errors.full_messages}, status: :unprocessable_entity
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
      .permit(:receiver_id)
      .merge(author_id: current_user.id)
  end
end
