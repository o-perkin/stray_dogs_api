require 'rails_helper'

RSpec.describe Subscription, :type => :model do

  context "Validations" do
    before(:each) do
      @subscription = build(:subscription)
    end

    it "is valid with valid attributes" do     
      expect(@subscription).to be_valid
    end

    it "is not valid if age_from greater_than age_to" do
      @subscription.age_from = 5
      @subscription.age_to = 2      
      expect(@subscription).to_not be_valid
    end
  end

  context "Associations" do
    it { should belong_to(:subscribe) }
  end
end