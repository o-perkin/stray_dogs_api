module Api
  module V1
    class SubscribesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_subscribe, only: [:index, :update, :destroy]
      before_action :set_subscribe_new, only: [:create]

      # GET /subscribes
      def index
        render json: {status: "Success",  message: "Loaded subscribe", data: @subscribe}, status: :ok
      end

      # POST /subscribes
      def create
        @subscribe.save!
        UserMailer.email_subscription_confirmation(current_user, @subscribe.subscriptions).deliver
        render json: {status: "Success",  message: "Subscribe created", data: @subscribe.subscriptions}, status: :ok    
      end

      # PATCH/PUT /subscribes/1
      def update
        @subscribe.update!(subscribe_params)
        UserMailer.email_subscription_confirmation(current_user, @subscribe.subscriptions).deliver
        render json: {status: "Success",  message: "Subscribe updated", data: @subscribe.subscriptions}, status: :ok 
      end

      # DELETE /subscribes/1
      def destroy
        @subscribe.destroy!
        render json: {status: "Success",  message: "Subscribe deleted"}, status: :ok
      end

      private

        def set_subscribe
          @subscribe = current_user.try(:subscribe)
        end

        def set_subscribe_new
          @subscribe = Subscribe.new(subscribe_params)
          @subscribe.user_id = current_user.id
        end  

        def subscribe_params
          params.require(:subscribe).permit(subscriptions_attributes: [:id, :breed, :city, :age_from, :age_to, :_destroy])
        end  
    end
  end
end