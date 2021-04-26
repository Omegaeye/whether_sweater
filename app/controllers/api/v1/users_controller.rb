class Api::V1::UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if params[:password] != params[:password_confirmation]
      return [false, param_invalid('password and password_confirmation', 'does not match')] 
    end

    new_params = user_params
    new_params[:email] = user_params[:email].downcase
    
    @user = User.create(new_params)
    
    
    if @user.save
      user_json = User.user_info(@user.id)
      @serial = UsersSerializer.new(user_json)
        render json: @serial, status: :created
    else
        render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
