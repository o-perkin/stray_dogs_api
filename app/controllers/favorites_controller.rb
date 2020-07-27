class FavoritesController < ApplicationController
  protect_from_forgery except: :update
  before_action :set_favorites, only: [:destroy]
  before_action :find_favorites_by_dog, only: [:update]

  def update 
    
    if @favorites == []
      Favorite.create(dog: Dog.find(params[:dog]), user: current_user)
      @favorite_exists = true
    else
      @favorites.destroy_all
      @favorite_exists = false
    end
    respond_to :js
  end

  def destroy    
    @favorites.destroy
    respond_to do |format|
      format.html { redirect_to my_favorites_path, notice: 'Dog was successfully destroyed.' }
    end
  end

  private

    def set_favorites
      @favorites = Favorite.find(params[:id])
    end

    def find_favorites_by_dog
      @favorites = Favorite.find_by_dog(Dog.find(params[:dog]), current_user)
    end
end
 