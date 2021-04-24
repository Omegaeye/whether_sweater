# frozen_string_literal: true
require 'SecureRandom'

class Api::V1::Users::SessionsController < Api::V1::UsersController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  def create
    
    binding.pry

    # SecureRandom.base64.tr('+/=', 'Qrt')
    # user = warden.authenticate!(:scope => :user)
    # token = Tiddle.create_and_return_token(user, request)
    # render json: { authentication_token: token }
  end

  def destroy
    # if current_user && Tiddle.expire_token(current_user, request)
    # head :ok
    # else
    #       # Client tried to expire an invalid token
    # render json: { error: 'invalid token' }, status: 401
    #  end
  end

  private

  #   # this is invoked before destroy and we have to override it
  # def verify_signed_out_user
  # end
end
