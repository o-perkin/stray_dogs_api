module NeededDogs
  extend ActiveSupport::Concern

  included do 
    before_action :set_needed_dogs, only: [:create, :update]
  end

  def set_needed_dogs
    @needed_dogs = []
    params[:subscribe][:subscriptions_attributes].each do |k, v|
      if v[:_destroy] == 'false'  
        @needed_dogs << Dog.where(breed_id: v[:breed_id],
                                 city_id: v[:city_id], 
                                 age_id: ((v[:age_from].to_i)..(v[:age_to].to_i))
                                 )
      end
    end
    @needed_dogs
  end
end

