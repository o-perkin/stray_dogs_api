require 'rails_helper'

RSpec.describe Dog, type: :model do
  describe "validations" do
    before(:each) do
      @dog = build(:dog)
    end

    it "is valid with valid attributes" do
      expect(@dog).to be_valid
    end

    it "is not valid without a name" do
      @dog.name = nil
      expect(@dog).to_not be_valid
    end

    it "is not valid without a user" do
      @dog.user_id = nil
      expect(@dog).to_not be_valid
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:favorites).dependent(:delete_all) }
  end

  describe ".search" do
    it "returns dogs with exact matching name" do
      dog = create(:dog, name: "Rex")
      create(:dog, name: "Buddy")

      expect(Dog.search("Rex")).to eq([dog])
    end

    it "returns all when search is nil" do
      expect(Dog.search(nil)).to eq(Dog.all)
    end

    it "returns all when search is empty" do
      expect(Dog.search("")).to eq(Dog.all)
    end
  end

  describe ".filters" do
    before(:each) do
      @breed = Dog.breeds.keys.first
      @city = Dog.cities.keys.second
      @age_from = 2
      @age_to = 4
      @params = {
        breed: @breed,
        city: @city,
        age_from: @age_from,
        age_to: @age_to
      }
    end

    it "returns scope with all filtered params" do
      expect(Dog.filters(@params)).to eq(
        Dog.where(breed: @breed, city: @city).where(age: @age_from..@age_to)
      )
    end

    it "returns scope without breed filter when breed is empty" do
      @params[:breed] = ""

      expect(Dog.filters(@params)).to eq(
        Dog.where(city: @city).where(age: @age_from..@age_to)
      )
    end

    it "returns scope without city filter when city is empty" do
      @params[:city] = ""

      expect(Dog.filters(@params)).to eq(
        Dog.where(breed: @breed).where(age: @age_from..@age_to)
      )
    end

    it "returns scope without age_from when age_from is empty" do
      @params[:age_from] = ""

      expect(Dog.filters(@params)).to eq(
        Dog.where(breed: @breed, city: @city).where(age: 1..@age_to)
      )
    end

    it "returns scope without age_to when age_to is empty" do
      @params[:age_to] = ""

      expect(Dog.filters(@params)).to eq(
        Dog.where(breed: @breed, city: @city).where(age: @age_from..10)
      )
    end

    it "returns all when all params are empty" do
      params = {
        breed: "",
        city: "",
        age_from: "",
        age_to: ""
      }

      expect(Dog.filters(params)).to eq(Dog.all)
    end
  end

  describe ".determine_age_range" do
    it "returns scope filtered by age_from and age_to" do
      params = { age_from: 2, age_to: 4 }

      expect(Dog.determine_age_range(params)).to eq(
        Dog.where(age: 2..4)
      )
    end

    it "returns scope filtered by age_from only" do
      params = { age_from: 2, age_to: nil }

      expect(Dog.determine_age_range(params)).to eq(
        Dog.where(age: 2..10)
      )
    end

    it "returns scope filtered by age_to only" do
      params = { age_from: nil, age_to: 4 }

      expect(Dog.determine_age_range(params)).to eq(
        Dog.where(age: 1..4)
      )
    end

    it "returns all if age_from and age_to are empty" do
      params = { age_from: nil, age_to: nil }

      expect(Dog.determine_age_range(params)).to eq(Dog.all)
    end
  end

  describe ".current_user" do
    it "returns scope with user by id parameter" do
      user_id = 1

      expect(Dog.current_user(user_id)).to eq(Dog.where(user_id: user_id))
    end

    it "returns no dog if no current user" do
      expect(Dog.current_user(nil)).to eq(Dog.where(user_id: nil))
    end
  end
end
