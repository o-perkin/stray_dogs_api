require 'rails_helper'

RSpec.describe Dog, :type => :model do

  let(:user) {
    User.new(email: "test@gmail.com", password: 'asdasd', first_name: 'Alex', last_name: 'Perkin')
  }

  5.times do |breed|
    Breed.create!(name: breed)
  end

  5.times do |city|
    City.create!(name: city)
  end

  5.times do |age|
    Age.create!(years: age)
  end

  subject { 
    described_class.new(
      dog_params = {
                    breed_id: 1,
                    city_id: 2,
                    age_id: 3,
                    user_id: User.last.id
                  }) 
  }

  it "is valid with valid attributes" do    
    expect(subject).to be_valid
  end

  it "is not valid without a breed" do
    subject.breed_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a city" do
    subject.city_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a age" do
    subject.age_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:user) }
  end
end