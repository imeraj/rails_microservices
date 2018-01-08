class UsersController < ApplicationController
  def index
    users = Services.user_service.get_all_users
    render json: users
  end

  def create
    user = Services.user_service.create_user user_params
    render json: user, status: :created,
                    location: users_url(user)
    rescue Barrister::RpcException => e
      render json: "#{e.message}".to_json, status: :unprocessable_entity
  end

private
  def user_params
    params.require(:user).permit(:full_name, :phone_number, :email).to_h || {}
  end
end
