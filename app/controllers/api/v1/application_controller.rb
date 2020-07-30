module Api
  module V1
    class ApplicationController < ActionController::API
      before_action :authenticate_user! 
      include DeviseWhitelist
    end
  end
end