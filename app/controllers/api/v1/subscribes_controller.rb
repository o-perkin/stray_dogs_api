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
        if @subscribe.save
          send_email(current_user, @subscribe.subscriptions, 'created')
        else
          render json: {status: "Error",  message: "Subscribe not saved", data: @subscribe.errors}, status: :unprocessable_entity 
        end
      end

      # PATCH/PUT /subscribes/1
      def update
        if @subscribe.user_id == current_user.id
          if @subscribe.update(subscribe_params)
            send_email(current_user, @subscribe.subscriptions, 'updated')
          else
            render json: {status: "Error",  message: "Subscribe not updated", data: @subscribe.errors}, status: :unprocessable_entity 
          end 
        else
          render json: {status: "Failed",  message: "Access denied"}, status: :forbidden
        end   
      end

      # DELETE /subscribes/1
      def destroy
        if @subscribe.user_id == current_user.id
          @subscribe.destroy
          render json: {status: "Success",  message: "Subscribe deleted"}, status: :ok
        else
          render json: {status: "Failed",  message: "Access denied"}, status: :forbidden
        end
      end

      private

        def set_subscribe
          @subscribe = current_user.subscribe if current_user
        end

        def set_subscribe_new
          @subscribe = Subscribe.new(subscribe_params)
          @subscribe.user_id = current_user.id
        end  

        def send_email(user, subscriptions, action)
          UserMailer.email_after_subscribing(user, subscriptions).deliver
          render json: {status: "Success",  message: "Subscribe #{action}", data: subscriptions}, status: :ok 
        end

        def subscribe_params
          params.require(:subscribe).permit(:user_id, subscriptions_attributes: [:id, :breed_id, :city_id, :age_from, :age_to, :_destroy])
        end   
    end
  end
end