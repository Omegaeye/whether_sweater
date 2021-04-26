# frozen_string_literal: true

class Api::V1::Users::SessionsController < Api::V1::UsersController

  def authenticate
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      user_json = User.user_log_in(@user.id)
      @serial = UsersSerializer.new(user_json)
      render json: @serial
    else
      render status: :unauthorized
    end
  end

end
