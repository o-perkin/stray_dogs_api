class Favorite < ApplicationRecord
  belongs_to :dog
  belongs_to :user

  def self.favorite_exists?(dog, user)
    Favorite.where(dog: dog, user: user) == [] ? false : true
  end

  def self.find_by_dog(dog, user)
    Favorite.where(dog: dog, user: user)
  end
end
