module Api
  module V1
    class DogsController < ApplicationController
      include SendEmails
      before_action :authenticate_user!, only: [:my_dogs, :new, :create, :update, :destroy, :edit, :favorite_dogs]
      before_action :set_dog, only: [:show, :edit, :update, :destroy]
      before_action :set_new_dog, only: [:create]      

      # GET /dogs
      def index 
        @dogs = sort_dogs.per(5).search(params[:search])        
        render json: {status: "Success",  message: "Loaded dogs", data: dogs_to_json(@dogs)}, status: :ok
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
        if current_user.id == @dog.user_id   
          render json: {status: "Success",  message: "Loaded dog", data: {dog: @dog}}, status: :ok 
        else 
          render json: {status: "Failed",  message: "Access denied"}, status: :forbidden
        end
      end

      # GET /my_dogs
      def my_dogs
        @dogs = sort_dogs.per(4).current_user(current_user.id)
        render json: {status: "Success",  message: "Loaded dogs", data: {dogs: @dogs, user: current_user}}, status: :ok
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
        if @dog.save
          send_emails(current_user, Subscription.find_by_dog_params(params[:dog]))
          render json: {status: "Success",  message: "Created a dog", data: @dog}, status: :created 
        else
          render json: {status: "Error",  message: "Dog not saved", data: @dog.errors}, status: :unprocessable_entity 
        end
      end

      # PATCH/PUT /dogs/1
      def update      
        if current_user.id == @dog.user_id
          if @dog.update(dog_params)
            render json: {status: "Success",  message: "Updated a dog", data: @dog}, status: :ok 
          else
            render json: {status: "Error",  message: "Dog not updated", data: @dog.errors}, status: :unprocessable_entity 
          end
        else
          render json: {status: "Failed",  message: "Access denied"}, status: :forbidden
        end      
      end

      # DELETE /dogs/1
      def destroy
        if current_user.id == @dog.user_id
          @dog.destroy
          render json: {status: "Success",  message: "Deleted a dog"}, status: :ok
        else
          render json: {status: "Failed",  message: "Access denied"}, status: :forbidden
        end
      end

      private

        def set_dog
          @dog ||= Dog.find(params[:id])
        end

        def set_new_dog
          @dog = Dog.new(dog_params)
          @dog.user_id = current_user.id
        end

        def sort_dogs
          Dog.filters(params).order(sort_column + " " + sort_direction).page(params[:page])
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

        def dogs_to_json dogs
          dogs_json = []
          dogs.each do |dog|
            new_dog = {
              id: dog.id,
              name: dog.name,
              breed: dog.breed,
              city: dog.city,
              age: dog.age,
              description: dog.description,
              favorite: Favorite.favorite_exists?(dog, current_user),
              user: dog.user,
              created_at: dog.created_at
            }            
            dogs_json << new_dog
          end
          dogs_json
        end
    end
  end
end

