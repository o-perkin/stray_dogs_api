class Dog < ApplicationRecord
  belongs_to :breed
  belongs_to :city
  belongs_to :age
  belongs_to :user
  has_many :favorites, dependent: :delete_all

  def self.search(search)
    if search && search != ""
      where(name: search)
    else 
      all
    end
  end

  def self.filters(breed, city, age_from, age_to)

    breed = nil if breed == ""
    city = nil if city == ""
    age_from = nil if age_from == ""
    age_to = nil if age_to == ""
    
    age = set_age(age_from, age_to)

    if breed && city && age
      where(breed_id: breed, city_id: city).where("age_id >= ?", age_from).where("age_id <= ?", age_to)
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

  private 

  def self.set_age(age_from, age_to)
    if age_from && age_to
      (age_from..age_to)
    elsif age_from 
      "#{age_from}.."
    elsif age_to
      1..age_to.to_i
    else 
      nil
    end
  end

end

