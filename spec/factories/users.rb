require 'faker'

FactoryBot.define do

  factory :user do
    email { Faker::Internet.unique.email }
    password { "asdasd" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end  
end
