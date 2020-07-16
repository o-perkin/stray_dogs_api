class Dog < ApplicationRecord
  belongs_to :breed
  belongs_to :city
  belongs_to :age
  belongs_to :user
  has_many :favorites, dependent: :delete_all
  validates :name, presence: true

  def self.search(search)
    if search && search != ""
      where(name: search)
    else 
      all
    end
  end

  def self.filters(params)

    modified_params = params.transform_values {|v| v == "" ? v = nil : v}    
    breed_city = modified_params.select { |k, v| v != nil && (k.to_s == "breed" || k.to_s == "city")}
    
    where(breed_city).set_age(modified_params[:age_from], modified_params[:age_to]).all
  end

  scope :current_user, ->(id) { where(user_id: id) }

  private 

  def self.set_age(age_from, age_to)
    
    if age_from || age_to
      age_from = 1 if age_from.nil?
      age_to = Age.last.id if age_to.nil?
      where("age_id >= ? AND age_id <= ?", age_from, age_to)
    else
      all
    end
  end

end

