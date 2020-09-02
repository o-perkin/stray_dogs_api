require 'faker'

FactoryBot.define do

  factory :dog do
    name { Faker::Creature::Dog.name }
    breed { Faker::Number.between(from: 1, to: 5) }
    city { Faker::Number.between(from: 1, to: 5) }
    age { Faker::Number.between(from: 1, to: 10) }
    user_id { create(:user).id }
  end  
end
