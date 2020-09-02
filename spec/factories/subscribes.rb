FactoryBot.define do

  factory :subscribe do
    user_id { create(:user).id }
    subscriptions_attributes { [{breed: "1", city: "2", age_from: "1", age_to: "2"}] }
  end
  
end
