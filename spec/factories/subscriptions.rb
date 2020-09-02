FactoryBot.define do

  factory :subscription do
    subscribe_id { create(:subscribe).id }
    breed { 2 }
    city { 3 }
    age_from { "1" }
    age_to { "2" }
  end
  
end
