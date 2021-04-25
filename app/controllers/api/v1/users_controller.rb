class Api::V1::UsersController < ApplicationController
include ApiKeyAuthenticatable
# prepend_before_action :authenticate_with_api_key!, only: [:index]

  def new
    @user = User.new
  end

  def create
    
    new_params = user_params
    new_params[:email] = user_params[:email].downcase
    
    @user = User.create(new_params)
    if @user.save
        user_json = User.user_info(@user.id)
        @serial = UsersSerializer.new(user_json)
        render json: @serial, status: :created and return
    else
        render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
        params.permit(:email, :password, :password_confirmation)
  end

end
