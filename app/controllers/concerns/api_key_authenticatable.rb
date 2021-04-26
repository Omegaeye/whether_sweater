module ApiKeyAuthenticatable
  extend ActiveSupport::Concern

  # include ActionController::HttpAuthentication::Basic::ControllerMethods
  # include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_api_key
  attr_reader :current_bearer

  # Use this to raise an error and automatically respond with a 401 HTTP status
  # code when API key authentication fails
  def authenticate_with_api_key!
    keep_slaying, response = screening_params(params)

    if keep_slaying

      if params[:api_key].present? && params[:origin].present? && params[:destination].present?
        @current_api_key = ApiKey.find_by token: params[:api_key]
        @current_bearer = current_api_key&.bearer
        
        # binding.pry
        
      else
        render status: :unauthorized
      end
    end
    # @current_bearer = authenticate_or_request_with_http_token &method(:authenticator)
  end

  # Use this for optional API key authentication
  # def authenticate_with_api_key
  #   @current_bearer = authenticate_with_http_token &method(:authenticator)
  # end

  private

  def screening_params(params)
    if params[:origin].nil? && params[:destination].nil? && params[:api_key].nil?
      return [false, param_missing(['either origin, or destination, or api_key'])]
    end

    if params[:origin] && params[:origin].length < 1
      return [false, param_bad('origin', 'cannot be empty/blank')]
    end

    if params[:destination] && params[:destination].length < 1
      return [false, param_bad('destination', 'cannot be empty/blank')]
    end

    [true, nil]
  end
  
  # attr_writer :current_api_key
  # attr_writer :current_bearer

  # def authenticator(http_token, options)
    
  #   @current_api_key = ApiKey.find_by token: http_token

  #   current_api_key&.bearer
  # end
end