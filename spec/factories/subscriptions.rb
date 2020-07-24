FactoryBot.define do

  factory :subscription do
    subscribe
    breed_id { "1" }
    city_id { "1" }
    age_from { "1" }
    age_to { "1" }
  end
  
end
