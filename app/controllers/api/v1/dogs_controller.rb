module Api
  module V1
    class DogsController < ApplicationController
      before_action :authenticate_user!, except: [:index, :show, :new]
      before_action :set_dog, only: [:show, :edit, :update, :destroy]
      before_action :find_subscriptions, only: [:create]
      before_action :set_new_dog, only: [:create]   
      around_action :check_authorization, only: [:update, :edit, :destroy]   

      NUMBER_OF_DOGS_PER_PAGE = 5

      # GET /dogs
      def index 
        @dogs = sort_dogs.search(params[:search])
        render json: {status: "Success",  message: "Loaded dogs", data: {dogs: dogs_to_json(@dogs), number_of_pages: (Dog.filters(params).length.to_f / NUMBER_OF_DOGS_PER_PAGE).ceil}}, status: :ok
      end

      # GET /dogs/1
      def show     
        render json: {status: "Success",  message: "Loaded dog", data: {dog: dogs_to_json([@dog])}}, status: :ok 
      end

      # GET /new_dog
      def new
        render json: {status: "Success",  message: "Loaded dogs params", data: {breed: Dog.breeds, city: Dog.cities, age: Dog.ages}}, status: :ok
      end

      # Get /dogs/edit/1
      def edit
        render json: {status: "Success",  message: "Loaded dog", data: {dog: dog_to_json_for_edit(@dog)}}, status: :ok 
      end

      # GET /my_dogs
      def my_dogs
        @dogs = sort_dogs.current_user(current_user.id)
        render json: {status: "Success",  message: "Loaded dogs", data: {dogs: dogs_to_json(@dogs), user: current_user, number_of_pages: (Dog.filters(params).current_user(current_user.id).length.to_f / NUMBER_OF_DOGS_PER_PAGE).ceil}}, status: :ok
      end

      # GET /favorite_dogs
      def favorite_dogs
        dogs = []
        current_user.favorites.each do |favorite|
          dogs << favorite.dog
        end
        render json: {status: "Success", message: "Loaded Favorites", data: dogs_to_json(dogs)}, status: :ok      
      end

      # POST /dogs
      def create  
        @dog.save!          
        if @subscriptions.empty?
          UserMailer.email_confirmation_of_created_dog(current_user).deliver      
        else
          UserMailer.email_that_dog_is_wanted(current_user, @subscriptions).deliver
          UserMailer.email_that_dog_appeared(current_user, @subscriptions).deliver
        end
        render json: {status: "Success",  message: "Created a dog", data: @dog}, status: :created 
      end

      # PATCH /dogs/1
      def update    
        @dog.update!(dog_params)
        render json: {status: "Success",  message: "Updated a dog", data: @dog}, status: :ok 
      end

      # DELETE /dogs/1
      def destroy
        @dog.destroy!
        render json: {status: "Success",  message: "Deleted a dog"}, status: :ok
      end

      private

        def set_dog
          @dog ||= Dog.find(params[:id])
        end

        def set_new_dog
          @dog = Dog.new(dog_params)
          @dog.user_id = current_user.id
        end

        def find_subscriptions
          @subscriptions = Subscription.find_by_dog_params(params[:dog])
        end

        def sort_dogs
          Dog.filters(params).order("#{sort_column} #{sort_direction}").page(params[:page]).per(NUMBER_OF_DOGS_PER_PAGE)
        end

        def sort_column
          Dog.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
        end

        def sort_direction
          %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
        end

        def dog_params
          params.require(:dog).permit(:name, :breed, :city, :age, :description, :user_id)
        end

        def dog_to_json_for_edit dog
          {
            name: dog.name,
            breed: dog.breed_before_type_cast,
            city: dog.city_before_type_cast,
            age: dog.age_before_type_cast,
            description: dog.description
          }
        end

        def dogs_to_json dogs
          dogs.map do |dog|
            {
              id: dog.id,
              name: dog.name,
              breed: dog.breed,
              city: dog.city,
              age: dog.age,
              description: dog.description,
              favorite: Favorite.favorite_exists?(dog.id, current_user),
              user: dog.user,
              created_at: dog.created_at
            }            
          end
        end

        def check_authorization
          begin
            if current_user.id == @dog.user_id || current_user.roles == 'site_admin' 
              yield
            else 
              render json: {status: "Failed",  message: "Access denied"}, status: :forbidden
            end
          end
        end   
    end
  end
end

