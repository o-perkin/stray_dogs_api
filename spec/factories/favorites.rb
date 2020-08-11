FactoryBot.define do

  factory :favorite do
    dog_id { create(:dog).id }
    user_id { create(:user).id }
  end
  
end
