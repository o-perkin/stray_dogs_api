class Subscription < ApplicationRecord
  belongs_to :subscribe
  belongs_to :breed, optional: true
  belongs_to :city, optional: true

  def self.find(params)
    where(breed_id: params[:breed_id], city_id: params[:city_id]).set_age(params[:age_id])
  end

  def self.set_age age
    where("age_from <= ?", age).where("age_to >= ?", age)
  end
end
