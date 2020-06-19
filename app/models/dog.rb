class Dog < ApplicationRecord
  belongs_to :breed
  belongs_to :city
  belongs_to :age
  belongs_to :user
  has_many :favorites, dependent: :delete_all

  def self.search(search)
    if search 
      where(name: search)
    else 
      all
    end
  end

  def self.filters(breed, city, age)
    breed = nil if breed == ""
    city = nil if city == ""
    age = nil if age == ""

    if breed && city && age
      where(breed_id: breed, city_id: city, age_id: age)
    elsif breed && city 
      where(breed_id: breed, city_id: city)
    elsif breed && age
      where(breed_id: breed, age_id: age)
    elsif city && age
      where(city_id: city, age_id: age)
    elsif breed
      where(breed_id: breed)
    elsif city
      where(city_id: city)
    elsif age
      where(age_id: age)
    else
      unscoped
    end
  end

 scope :current_user, ->(id) { where(user_id: id) }

end