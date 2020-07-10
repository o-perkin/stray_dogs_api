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

  def self.filters(params = { breed: nil, city: nil, age_from: nil, age_to: nil })

    modified_params = params.transform_values {|v| v == "" ? v = nil : v}    
    breed_city = modified_params.select { |k, v| v != nil && (k.to_s == "breed" || k.to_s == "city")}

    where(breed_city).set_age(modified_params[:age_from], modified_params[:age_to]).all
  end

  scope :current_user, ->(id) { where(user_id: id) }

  private 

  def self.set_age(age_from, age_to)
    
    if age_from.nil? && age_to.nil?
      all
    else
      age_from.nil? ? age_from = 1 : age_from
      age_to.nil? ? age_to = Age.last.id : age_to
      where("age_id >= ? AND age_id <= ?", age_from, age_to)
    end
  end

end

