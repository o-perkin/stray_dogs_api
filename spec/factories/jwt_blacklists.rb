FactoryBot.define do
  factory :jwt_blacklist do
    jti { "MyString" }
    exp { "2020-08-03 10:23:41" }
  end
end
