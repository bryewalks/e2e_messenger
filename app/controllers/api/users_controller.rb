class Api::UsersController < ApplicationController
  wrap_parameters :user, include: [:name, :email, :password, :password_confirmation]
  
  def create
    user = User.new(user_params)

    if user.save
      render json: {message: "User created successfully"}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end

  def search
    name = params[:search].downcase
    @user = User.find_by({name: name})
    if Conversation.between(current_user.id, @user.id).first || @user.id === current_user.id
      render json: {error: "User not found"}, status: :not_found
    else
      render 'show.json.jbuilder'
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end
  
end

