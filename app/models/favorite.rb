class Favorite < ApplicationRecord
  belongs_to :dog
  belongs_to :user

  def self.favorite_exists?(dog_id, user)
    where(dog_id: dog_id, user_id: user) != []
  end

  def self.find_by_dog(dog, user)
    where(dog: dog, user: user)
  end
end
