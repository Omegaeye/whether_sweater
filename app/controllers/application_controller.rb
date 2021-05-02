class ApplicationController < ActionController::API
  private

  def param_missing(returns)
    render json: JSON.generate({
                                 error: 'require parameter is missing',
                                 errors: returns.map { |field| "#{field} parameter was not included in your request" }
                               }), status: :bad_request
  end

  def param_bad(param, reason)

    render json: JSON.generate({
                                 error: 'parameter value is bad',
                                 errors: ["#{param} parameter is bad: #{reason}"]
                               }), status: :bad_request
  end

  def param_invalid(param, reason)
    render json: JSON.generate({
                                 error: 'parameter value is bad',
                                 errors: ["#{param} parameter is bad: #{reason}"]
                               }), status: :unprocessable_entity
  end

  def bad_request( reason)
    render json: JSON.generate({
                                 error: 'Bad Request for your parameter',
                                 errors: "parameter is bad: #{reason}"
                               }), status: :bad_request
  end

  def check_params_location
    if params[:location].nil?
      return [false, param_missing(['location'])]
    end
    
    if params[:location] && params[:location].length <= 1
      return [false, param_bad('location', 'cannot be empty/blank')]
    end
  end
  
end
