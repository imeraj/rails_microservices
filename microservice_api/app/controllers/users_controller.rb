class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created, location: users_url(user)
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

private
  def user_params
    params.require(:user).permit(:full_name, :phone_number, :email)
  end
end
