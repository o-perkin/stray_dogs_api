require 'rails_helper'

RSpec.describe Subscription, :type => :model do

  context "Validations" do
    before(:each) do
      @subscription = build(:subscription)
    end

    it "is valid with valid attributes" do     
      expect(@subscription).to be_valid
    end

    it "is not valid without subscribe" do
      @subscription.subscribe = nil
      expect(@subscription).to_not be_valid
    end

    it "is not valid without a breed" do
      @subscription.breed_id = nil
      expect(@subscription).to_not be_valid
    end

    it "is not valid without a city" do
      @subscription.city_id = nil
      expect(@subscription).to_not be_valid
    end

    it "is not valid without age_to" do
      @subscription.age_to = nil
      expect(@subscription).to_not be_valid
    end

    it "is not valid if age_from greater_than age_to" do
      @subscription.age_from = 5
      @subscription.age_to = 2      
      expect(@subscription).to_not be_valid
    end
  end

  context "Associations" do
    it { should belong_to(:subscribe) }
    it { should belong_to(:breed) }
    it { should belong_to(:city) }
  end
end