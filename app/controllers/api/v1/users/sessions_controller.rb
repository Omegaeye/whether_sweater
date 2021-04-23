# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  def create
    user = warden.authenticate!(:scope => :user)
    token = Tiddle.create_and_return_token(user, request)
    render json: { authentication_token: token }
  end

  def destroy
    if current_user && Tiddle.expire_token(current_user, request)
    head :ok
    else
          # Client tried to expire an invalid token
    render json: { error: 'invalid token' }, status: 401
     end
  end

  private

    # this is invoked before destroy and we have to override it
  def verify_signed_out_user
  end
end
