class FavoritesController < ApplicationController

  def update
  
    favorite = Favorite.where(dog: Dog.find(params[:dog]), user: current_user)
    if favorite == []
      Favorite.create(dog: Dog.find(params[:dog]), user: current_user)
      @favorite_exists = true
    else
      favorite.destroy_all
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    respond_to do |format|
      format.html { redirect_to my_favorites_path, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
 