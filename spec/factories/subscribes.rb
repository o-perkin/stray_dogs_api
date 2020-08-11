FactoryBot.define do

  factory :subscribe do
    user_id { create(:user).id }
    subscriptions_attributes { [{breed_id: create(:breed).id, city_id: create(:city).id, age_from: "1", age_to: "2"}] }
  end
  
end
