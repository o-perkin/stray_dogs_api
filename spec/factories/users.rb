FactoryBot.define do

  factory :user do
    sequence(:email) { |n| "test-#{n}@example.com" }
    password { "asdasd" }
    first_name { "Name" }
    last_name { "LastName" }
  end  
end
