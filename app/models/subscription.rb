class Subscription < ApplicationRecord
  belongs_to :subscribe
  belongs_to :breed
  belongs_to :city
  validates :breed_id, presence: true
  validates :city_id, presence: true
  validates :age_from, presence: true
  validates :age_to, presence: true
  validates_numericality_of :age_to, greater_than_or_equal_to: :age_from

  def self.find_by_dog_params params
    where(breed_id: params[:breed_id], city_id: params[:city_id]).set_age(params[:age_id])
  end

  def self.set_age age
    where("age_from <= ?", age).where("age_to >= ?", age)
  end
end
 