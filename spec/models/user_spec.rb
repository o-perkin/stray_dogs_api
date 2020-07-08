require 'rails_helper'

RSpec.describe User, :type => :model do

  subject { 
    described_class.new(
      user_params = {
                      email: "test@gmail.com",
                      password: "asdasd",
                      first_name: "Name",
                      last_name: "LastName"
                    }) 
  }

  it "is valid with valid attributes" do    
    expect(subject).to be_valid
  end

  it "is not valid without email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without first name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without last name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should have_many(:dogs) }
    it { should have_many(:favorites) }
    it { should have_one(:subscribe) }
  end
end