module FavoritesHelper
  
  def favorite_text_for_show
   return @favorite_exists ? "Remove from favorites" : "Add to favorites"
  end

  def favorite_text_for_list(user, dog_id)
    user.favorites.find_by_dog_id(dog_id) ? "Remove from favorites" : "Add to favorites"
  end
end
 