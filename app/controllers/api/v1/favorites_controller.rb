module Api
  module V1
    class FavoritesController < ApplicationController
      before_action :authenticate_user!, only: [:update]
      before_action :find_favorites_by_dog, only: [:update]

      def update     
        if @favorites == []
          create_favorite
          @favorite_exists = true
        else
          @favorites.destroy_all
          @favorite_exists = false
        end
        render json: {message: "Favorite Updated", data: @favorite_exists}, status: :ok
      end

      private

        def find_favorites_by_dog
          @favorites = Favorite.find_by_dog(Dog.find(params[:dog]), current_user)
        end

        def create_favorite
          Favorite.create(dog: Dog.find(params[:dog]), user_id: current_user.id)
        end
    end
  end
end