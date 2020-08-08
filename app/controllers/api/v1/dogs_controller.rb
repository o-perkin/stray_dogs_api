module Api
  module V1
    class DogsController < ApplicationController
      include SendEmails
      before_action :authenticate_user!, only: [:my_list, :create, :update, :destroy]
      before_action :set_dog, only: [:show, :edit, :update, :destroy]
      before_action :set_new_dog, only: [:create]
      

      # GET /
      def home
      end

      # GET /dogs
      def index 
        @dogs = set_list_of_dogs.per(5).search(params[:search])
        render json: {status: "Success",  messsage: "Loaded dogs", data: @dogs}, status: :ok
      end

      # GET /my_list
      def my_list
        @dogs = set_list_of_dogs.per(2).current_user(current_user.id)
        render json: {status: "Success",  messsage: "Loaded dogs", data: @dogs}, status: :ok
      end

      # GET /my_favorites
      def favorites
      end  

      # GET /dogs/1
      def show   
        @favorite_exists = Favorite.favorite_exists?(@dog, current_user)
        render json: {status: "Success",  messsage: "Loaded dog", data: {dogs: @dog, favorite_exists: @favorite_exists}}, status: :ok 
      end

      # GET /dogs/new
      def new
        @dog = Dog.new
      end

      # GET /dogs/1/edit
      def edit
        render json: {status: "Success",  messsage: "Loaded dog", data: @dog}, status: :ok 
      end

      # POST /dogs
      def create  
        if @dog.save
          send_emails(current_user, set_subscriptions)
          render json: {status: "Success",  messsage: "Created a dog", data: @dog}, status: :ok 
        else
          render json: {status: "Error",  messsage: "Dog not saved", data: @dog.errors}, status: :unprocessable_entity 
        end
      end

      # PATCH/PUT /dogs/1
      def update      
        if current_user.id == @dog.user_id
          if @dog.update(dog_params)
            render json: {status: "Success",  messsage: "Updated a dog", data: @dog}, status: :ok 
          else
            render json: {status: "Error",  messsage: "Dog not updated", data: @dog.errors}, status: :unprocessable_entity 
          end
        else
          render json: {status: "Failed",  messsage: "Access denied"}, status: :forbidden
        end      
      end

      # DELETE /dogs/1
      def destroy
        if current_user.id == @dog.user_id
          @dog.destroy
          render json: {status: "Success",  messsage: "Deleted a dog"}, status: :ok
        else
          render json: {status: "Failed",  messsage: "Access denied"}, status: :forbidden
        end
      end

      private

        def set_dog
          @dog = Dog.find(params[:id])
        end

        def set_new_dog
          @dog = Dog.new(dog_params)
          @dog.user_id = current_user.id
        end

        def set_subscriptions      
          Subscription.find_by_dog_params(params[:dog])
        end

        def set_list_of_dogs
          Dog.filters(set_filter_params).order(sort_column + " " + sort_direction).page(params[:page])
        end

        def dog_params
          params.require(:dog).permit(:name, :breed_id, :city_id, :age_id, :description, :user_id)
        end

        def set_filter_params
          {breed: params[:breed_id], city: params[:city_id], age_from: params[:age_from], age_to: params[:age_to]}.transform_values {|v| v == "" ? v = nil : v}   
        end

        def sort_column
          Dog.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
        end

        def sort_direction
          %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
        end
    end
  end
end

