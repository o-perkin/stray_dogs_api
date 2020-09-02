class Subscription < ApplicationRecord
  belongs_to :subscribe
  validates_numericality_of :age_to, greater_than_or_equal_to: :age_from

  def self.find_by_dog_params params
    where(breed: params[:breed], city: params[:city]).set_age(params[:age])
  end

  def self.set_age age
    where("age_from <= ?", age).where("age_to >= ?", age)
  end
end
 