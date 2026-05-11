module Api
  module V1
    class AiAgentStatusController < ApplicationController
      def show
        render json: { status: "ok", source: "openclaw" }, status: :ok
      end
    end
  end
end
