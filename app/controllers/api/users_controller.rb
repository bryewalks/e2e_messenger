class Api::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: {message: "User created successfully"}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end

  #refactor this
  def search
    if params[:search].blank?
      render json: {errors: "Search term cannot be blank"}, status: :bad_request
    else
      parameter = params[:search].downcase
      @users = User.where('lower(name) LIKE ? AND id != ?', parameter, current_user.id)
      unless Conversation.between(current_user.id, @users.first).first
        render 'index.json.jbuilder'
      else
        render json: {error: "User not found"}, status: :not_found
      end
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end
  
end

