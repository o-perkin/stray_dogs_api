FactoryBot.define do

  factory :subscription do
    subscribe_id { create(:subscribe).id }
    breed_id { create(:breed).id }
    city_id { create(:city).id }
    age_from { "1" }
    age_to { "1" }
  end
  
end
