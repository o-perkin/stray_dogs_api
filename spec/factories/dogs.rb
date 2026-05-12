require 'faker'

FactoryBot.define do
  factory :dog do
    name { Faker::Creature::Dog.name }
    breed { Dog.breeds.keys.first }
    city { Dog.cities.keys.first }
    age { Dog.ages.keys.first }
    user_id { create(:user).id }
  end
end
