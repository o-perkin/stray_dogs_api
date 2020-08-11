class Dog < ApplicationRecord
  has_many :favorites, dependent: :delete_all
  belongs_to :breed
  belongs_to :city
  belongs_to :age
  belongs_to :user
  validates :name, presence: true
  validates :breed_id, presence: true
  validates :city_id, presence: true
  validates :age_id, presence: true
  validates :user_id, presence: true

  scope :current_user, ->(id) { where(user_id: id) }

  def self.search search
    (search && search != "") ? where(name: search) : all
  end

  def self.filters params
    where(set_breed_and_city(params)).set_age(params).all
  end  

  private 

    def self.set_age params
      if params[:age_from] || params[:age_to]
        where(age_id: set_age_from(params[:age_from])..set_age_to(params[:age_to]))
      else
        all
      end
    end

    def self.set_breed_and_city params
      params.select { |k, v| v != nil && (k.to_s == "breed" || k.to_s == "city")}
    end

    def self.set_age_from age_from
      age_from.nil? ? 1 : age_from.to_i
    end

    def self.set_age_to age_to
      age_to.nil? ? Age.last.id : age_to.to_i
    end
end