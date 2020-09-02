class ApplicationController < ActionController::API
  include DeviseWhitelist
  around_action :rescue_errors

  private 
  
    def rescue_errors
      begin
        yield
      rescue => e
        render json: {status: "Error",  message: e.message}, status: :unprocessable_entity 
      end
    end   
end
 