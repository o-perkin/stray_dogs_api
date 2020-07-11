FactoryBot.define do

  factory :subscribe do
    user_id { "1" }
    subscriptions_attributes { [{breed_id: "1", city_id: "1", age_from: "1", age_to: "2"}] }
  end
  
end
