class Dog < ApplicationRecord
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
  has_many :favorites, dependent: :delete_all
  belongs_to :user
  validates :name, presence: true
  validates :user_id, presence: true

  scope :current_user, ->(id) { where(user_id: id) }

  def self.search search
    search.present? ? where('LOWER(name) LIKE ?', "%#{sanitize_sql_like(search.downcase)}%") : all
  end

  def self.filters params
    normalized_params = normalize_filter_params(params)

    where(select_breed_and_city(normalized_params))
      .determine_age_range(normalized_params)
  end  

  private 

    def self.normalize_filter_params params
      {
        breed: enum_filter_value(breeds, params[:breed]),
        city: enum_filter_value(cities, params[:city]),
        age_from: params[:age_from].presence,
        age_to: params[:age_to].presence
      }
    end

    def self.enum_filter_value enum_values, value
      return nil if value.blank?

      value_string = value.to_s
      enum_values.key?(value_string) ? enum_values[value_string] : value_string
    end

    def self.determine_age_range params
      if params[:age_from] || params[:age_to]
        where(age: determine_age_from(params[:age_from])..determine_age_to(params[:age_to]))
      else
        all
      end
    end

    def self.select_breed_and_city params
      params.select { |k, v| v != nil && (k == :breed || k == :city)}
    end

    def self.determine_age_from age_from
      age_from.nil? ? 1 : age_from.to_i
    end

    def self.determine_age_to age_to
      age_to.nil? ? 10 : age_to.to_i
    end
end