require 'faker'

FactoryBot.define do

  factory :dog do
    name { Faker::Creature::Dog.name }
    breed
    city
    age
    user
  end  
end
