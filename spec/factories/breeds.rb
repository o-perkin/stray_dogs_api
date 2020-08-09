require 'faker'

FactoryBot.define do

  factory :breed do
    name { Faker::Creature::Dog.breed }
  end  
end
