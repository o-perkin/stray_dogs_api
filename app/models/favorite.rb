class Favorite < ApplicationRecord
  belongs_to :dog
  belongs_to :user

  def self.favorite_exists?(dog, user)
    where(dog: dog, user: user) != []
  end

  def self.find_by_dog(dog, user)
    where(dog: dog, user: user)
  end
end
