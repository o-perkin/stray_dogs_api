require 'rails_helper'

RSpec.describe User, :type => :model do 

  let!(:user) { build(:user) }

  context "Validations" do    

    it "is valid with valid attributes" do   
      expect(user).to be_valid
    end

    it "is not valid without email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is not valid without password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "is not valid without first name" do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it "is not valid without last name" do
      user.last_name = nil
      expect(user).to_not be_valid
    end

    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe "Associations" do
    it { should have_many(:dogs) }
    it { should have_many(:favorites) }
    it { should have_one(:subscribe) }
  end
end