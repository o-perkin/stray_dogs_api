class Dog < ApplicationRecord
  has_many :favorites, dependent: :delete_all
  belongs_to :user

  enum breed: {
    'Labrador' => 1, 
    'German Shepherd' => 2, 
    'Bulldog' => 3, 
    'Beagle' => 4, 
    'Poodle' => 5
  }
  enum city: {
    'Lviv' => 1, 
    'Kyiv' => 2, 
    'Ternopil' => 3, 
    'Kharkiv' => 4, 
    'Dnipro' => 5
  }
  enum age: {
    '1' => 1, 
    '2' => 2, 
    '3' => 3, 
    '4' => 4, 
    '5' => 5, 
    '6' => 6, 
    '7' => 7, 
    '8' => 8, 
    '9' => 9, 
    '10' => 10
  }  

  scope :current_user, ->(id) { where(user_id: id) }

  def self.search search
    search.present? ? where(name: search) : all
  end

  def self.filters params    
    where(select_breed_and_city(convert_empty_to_nil(params)))
    .determine_age_range(convert_empty_to_nil(params))
    .all
  end  

  private 

    def self.convert_empty_to_nil params
      {
        breed: params[:breed], 
        city: params[:city], 
        age_from: params[:age_from], 
        age_to: params[:age_to]
      }
      .transform_values(&:presence)
    end

    def self.determine_age_range params
      if params[:age_from] || params[:age_to]
        where(age: determine_age_from(params[:age_from])..determine_age_to(params[:age_to]))
      else
        all
      end
    end

    def self.select_breed_and_city params
      params.select { |k, v| (k == :breed || k == :city) && v }
    end

    def self.determine_age_from age_from
      age_from.nil? ? 1 : age_from.to_i
    end

    def self.determine_age_to age_to
      age_to.nil? ? 10 : age_to.to_i
    end
end