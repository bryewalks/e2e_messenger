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

  # def find_conversation!
  #   if params[:receiver_id]
  #     @receiver = User.find_by(id: params[:receiver_id])
  #     redirect_to(root_path) and return unless @receiver
  #     @conversation = Conversation.between(current_user.id, @receiver.id)[0]
  #   else
  #     @conversation = Conversation.find_by(id: params[:conversation_id])
  #     redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
  #   end
  # end
end
