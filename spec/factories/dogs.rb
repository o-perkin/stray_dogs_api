require 'faker'

FactoryBot.define do
  factory :dog do
    name { Faker::Creature::Dog.name }
    breed { 'Labrador' }
    city { 'Lviv' }
    age { '1' }
    user
  end
end
