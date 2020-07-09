require 'rails_helper'

RSpec.describe Dog, :type => :model do

  context "Vadidations" do

    before(:all) do
      @dog = create(:dog)
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
        @params = {breed: 1, city: 2, age_from: 2, age_to: 4}
      end

      it 'should return scope with all filtered params' do        
        expect(Dog.filters(@params[:breed], @params[:city], @params[:age_from], @params[:age_to])).to eq(Dog.where(breed_id: @params[:breed], city_id: @params[:city]).where("age_id >= ?", @params[:age_from]).where("age_id <= ?", @params[:age_to]))
      end

      it 'should return scope with all filtered params except breed' do   
        @params[:breed] = nil     
        expect(Dog.filters(@params[:breed], @params[:city], @params[:age_from], @params[:age_to])).to eq(Dog.where(city_id: @params[:city]).where("age_id >= ?", @params[:age_from]).where("age_id <= ?", @params[:age_to]))
      end

      it 'should return scope with all filtered params except city' do   
        @params[:city] = nil     
        expect(Dog.filters(@params[:breed], @params[:city], @params[:age_from], @params[:age_to])).to eq(Dog.where(breed_id: @params[:breed]).where("age_id >= ?", @params[:age_from]).where("age_id <= ?", @params[:age_to]))
      end

      it 'should return scope with all filtered params except age_from' do   
        @params[:age_from] = nil     
        expect(Dog.filters(@params[:breed], @params[:city], @params[:age_from], @params[:age_to])).to eq(Dog.where(breed_id: @params[:breed], city_id: @params[:city]).where("age_id >= ?", 1).where("age_id <= ?", @params[:age_to]))
      end

      it 'should return scope with all filtered params except age_to' do   
        @params[:age_to] = nil     
        expect(Dog.filters(@params[:breed], @params[:city], @params[:age_from], @params[:age_to])).to eq(Dog.where(breed_id: @params[:breed], city_id: @params[:city]).where("age_id >= ?", @params[:age_from]))
      end
    end
  end
end

