require 'rails_helper'

RSpec.describe User, :type => :model do  

  let(:user) { build(:user) }
  before(:each) { user.save }

  context 'email uniqueness' do
    let(:user1) { build(:user) }

    it { expect(user1).to_not be_valid }
  end  

  context "Validations" do    

    it "is valid with valid attributes" do 
    user.email = "ex@gmail.com"   
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
  end

  describe "Associations" do
    it { should have_many(:dogs) }
    it { should have_many(:favorites) }
    it { should have_one(:subscribe) }
  end
end