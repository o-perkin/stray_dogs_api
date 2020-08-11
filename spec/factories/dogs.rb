require 'faker'

FactoryBot.define do

  factory :dog do
    name { Faker::Creature::Dog.name }
    breed_id { create(:breed).id }
    city_id { create(:city).id }
    age_id { create(:age).id }
    user_id { create(:user).id }
  end  
end
