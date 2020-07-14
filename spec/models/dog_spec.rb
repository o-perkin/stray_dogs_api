require 'rails_helper'

RSpec.describe Dog, :type => :model do

  context "Vadidations" do

    before(:each) do
      @dog = build(:dog)
    end

    it "is valid with valid attributes" do     
      expect(@dog).to be_valid
    end

    it "is not valid without a breed" do
      @dog.breed_id = nil
      expect(@dog).to_not be_valid
    end

    it "is not valid without a city" do
      @dog.city_id = nil
      expect(@dog).to_not be_valid
    end

    it "is not valid without a age" do
      @dog.age_id = nil
      expect(@dog).to_not be_valid
    end

    it "is not valid without a user" do
      @dog.user_id = nil
      expect(@dog).to_not be_valid
    end
  end

  context "Associations" do
    it { should belong_to(:breed) }
    it { should belong_to(:city) }
    it { should belong_to(:age) }
    it { should belong_to(:user) }
    it { should have_many(:favorites).dependent(:delete_all) }
  end

  context "Scopes" do

    describe '#search' do
      it 'should return scope with searching name if search exist' do
        params = "Name"
        expect(Dog.search(params)).to eq(Dog.where(name: params))
      end

      it 'should return scope all when params are nil' do
        params = nil
        expect(Dog.search(params)).to eq(Dog.all)
      end

      it 'should return scope all when params are empty' do
        params = ""
        expect(Dog.search(params)).to eq(Dog.all)
      end
    end

    describe '#filters' do
      before(:each) do
        @breed = 1
        @city = 2
        @age_from = 2
        @age_to = 4
        @params = {breed: @breed, city: @city, age_from: @age_from, age_to: @age_to}
      end

      it 'should return scope with all filtered params' do  
        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where(breed_id: @breed, city_id: @city).where("age_id >= ? AND age_id <= ?", @age_from, @age_to).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope with all filtered params except breed' do   
        @params[:breed] = ""     

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where(city_id: @city).where("age_id >= ? AND age_id <= ?", @age_from, @age_to).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope with all filtered params except city' do   
        @params[:city] = ""  

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where(breed_id: @breed).where("age_id >= ? AND age_id <= ?", @age_from, @age_to).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope with all filtered params except age_from' do   
        @params[:age_from] = ""  

        filtered_by_method = Dog.filters(@params)
        filtered_without_method = Dog.where(breed_id: @breed, city_id: @city).where("age_id >= ? AND age_id <= ?", 1, @age_to).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope with all filtered params except age_to' do   
        @params[:age_to] = "" 

        filtered_by_method = Dog.filters(@params)
        filtered_without_method = Dog.where(breed_id: @breed, city_id: @city).where("age_id >= ? AND age_id <= ?", @age_from, Age.last.id).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope with all filtered params except breed and city' do   
        @params[:breed] = ""  
        @params[:city] = ""  

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where("age_id >= ? AND age_id <= ?", @age_from, @age_to).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope with all filtered params except age_from and age_to' do   
        @params[:age_from] = ""  
        @params[:age_to] = ""  

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where(breed_id: @breed, city_id: @city)

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope with all filtered params except breed and age_from' do           
        @params[:breed] = ""  
        @params[:age_from] = ""  

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where(city_id: @city).where("age_id >= ? AND age_id <= ?", 1, @age_to).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope with all filtered params except breed and age_to' do           
        @params[:breed] = ""  
        @params[:age_to] = ""  

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where(city_id: @city).where("age_id >= ? AND age_id <= ?", @age_from, Age.last.id).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope with all filtered params except city and age_from' do           
        @params[:city] = ""  
        @params[:age_from] = ""  

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where(breed_id: @breed).where("age_id >= ? AND age_id <= ?", 1, @age_to).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope with all filtered params except city and age_to' do           
        @params[:city] = ""  
        @params[:age_to] = ""  

        filtered_by_method = Dog.filters(@params)
        filtered_without_method = Dog.where(breed_id: @breed).where("age_id >= ? AND age_id <= ?", @age_from, Age.last.id).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope filtered by breed only' do           
        @params[:city] = ""  
        @params[:age_from] = ""  
        @params[:age_to] = ""  

        filtered_by_method = Dog.filters(@params)
        filtered_without_method = Dog.where(breed_id: @breed)

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope filtered by city only' do           
        @params[:breed] = ""  
        @params[:age_from] = ""  
        @params[:age_to] = ""  

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where(city_id: @city)

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope filtered by age_from only' do           
        @params[:breed] = ""  
        @params[:city] = ""  
        @params[:age_to] = ""  

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where("age_id >= ? AND age_id <= ?", @age_from, Age.last.id).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope filtered by age_to only' do           
        @params[:breed] = ""  
        @params[:city] = ""  
        @params[:age_from] = ""  

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.where("age_id >= ? AND age_id <= ?", 1, @age_to).all

        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return all if all params are empty' do           
        @params[:breed] = ""  
        @params[:city] = ""  
        @params[:age_from] = ""  
        @params[:age_to] = ""  

        filtered_by_method = Dog.filters(@params) 
        filtered_without_method = Dog.all

        expect(filtered_by_method).to eq(filtered_without_method)
      end
    end

    describe '#set_age' do

      before(:each) do
        @age_from = 2
        @age_to = 4
      end

      it 'should return scope filtered by age_from and age_to' do 
        filtered_by_method = Dog.set_age(@age_from, @age_to)
        filtered_without_method = Dog.where("age_id >= ? AND age_id <= ?", @age_from, @age_to).all
        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope filtered by age_from only' do 
        @age_to = nil
        filtered_by_method = Dog.set_age(@age_from, @age_to)
        filtered_without_method = Dog.where("age_id >= ? AND age_id <= ?", @age_from, Age.last.id).all
        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return scope filtered by age_to only' do 
        @age_from = nil
        filtered_by_method = Dog.set_age(@age_from, @age_to)
        filtered_without_method = Dog.where("age_id >= ? AND age_id <= ?", 1, @age_to).all
        expect(filtered_by_method).to eq(filtered_without_method)
      end

      it 'should return all if age_from and age_to are empty' do 
        @age_from = nil
        @age_to = nil
        filtered_by_method = Dog.set_age(@age_from, @age_to).all
        filtered_without_method = Dog.all
        expect(filtered_by_method).to eq(filtered_without_method)
      end
    end

    describe '#current_user' do

      before(:each) do
        @user_id = 1
      end

      it 'should return scope with user by id parameter' do 
        expect(Dog.current_user(@user_id)).to eq(Dog.where(user_id: @user_id))
      end

      it 'should return no dog if no current user' do 
        expect(Dog.current_user(nil)).to eq(Dog.where(user_id: nil))
      end
    end
  end
end
