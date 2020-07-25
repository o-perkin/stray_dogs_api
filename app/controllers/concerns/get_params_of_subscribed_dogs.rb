module GetParamsOfSubscribedDogs
  extend ActiveSupport::Concern

  included do 
    before_action :get_params_of_subscribed_dogs, only: [:create, :update]
  end

  def get_params_of_subscribed_dogs
    breed, city, age = {}, {}, {}
    params[:subscribe][:subscriptions_attributes].each do |k, v|
      if v[:_destroy] == 'false'         
        breed[k] = v[:breed_id] 
        city[k] = v[:city_id] 
        age[k] = ((v[:age_from].to_i)..(v[:age_to].to_i))
      end       
    end 
    @params_of_subscribed_dogs = { breed: breed, city: city, age: age }
  end 
end