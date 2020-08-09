require 'faker'

FactoryBot.define do

  factory :age do
    years { Faker::Number.between(from: 1, to: 10) }
  end  
end
