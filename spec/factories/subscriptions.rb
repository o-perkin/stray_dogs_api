FactoryBot.define do
  factory :subscription do
    subscribe_id { create(:subscribe).id }
    breed { 1 }
    city { 1 }
    age_from { 1 }
    age_to { 2 }
  end
end
