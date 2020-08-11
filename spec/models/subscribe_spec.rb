require 'rails_helper'

RSpec.describe Subscribe, :type => :model do

  context "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:subscriptions).dependent(:destroy) }
    it { should accept_nested_attributes_for(:subscriptions).allow_destroy(true)}
  end

  context "Vadidations" do

    before(:all) do
      @subscribe = build(:subscribe)
    end

    it { should validate_presence_of(:subscriptions) }

    it "is valid with valid attributes" do     
      expect(@subscribe).to be_valid
    end

    it "is not valid without user id" do
      @subscribe.user_id = nil
      expect(@subscribe).to_not be_valid
    end

    it "is not valid without subscriptions" do
      @subscribe.subscriptions = []
      expect(@subscribe).to_not be_valid
    end
  end

end