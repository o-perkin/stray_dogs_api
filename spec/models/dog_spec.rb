require 'rails_helper'

RSpec.describe Dog, type: :model do
  describe 'validations' do
    subject(:dog) { build(:dog) }

    it { is_expected.to be_valid }

    it 'requires a name' do
      dog.name = nil
      expect(dog).not_to be_valid
    end

    it 'requires a user' do
      dog.user = nil
      expect(dog).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:favorites).dependent(:delete_all) }
  end

  describe '.search' do
    before do
      create(:dog, name: 'Sirius')
      create(:dog, name: 'Albus')
    end

    it 'returns dogs matching the supplied name fragment' do
      expect(described_class.search('siri').pluck(:name)).to eq(['Sirius'])
    end

    it 'returns all dogs when search is blank' do
      expect(described_class.search('').count).to eq(2)
    end
  end

  describe '.filters' do
    before do
      create(:dog, name: 'Albus', breed: 'Labrador', city: 'Lviv', age: '3')
      create(:dog, name: 'Sirius', breed: 'German Shepherd', city: 'Kyiv', age: '5')
      create(:dog, name: 'Rex', breed: 'Labrador', city: 'Kyiv', age: '7')
    end

    it 'returns all dogs when no filters are present' do
      expect(described_class.filters({}).pluck(:name)).to contain_exactly('Albus', 'Sirius', 'Rex')
    end

    it 'filters by breed' do
      expect(described_class.filters(breed: 'Labrador').pluck(:name)).to contain_exactly('Albus', 'Rex')
    end

    it 'filters by city' do
      expect(described_class.filters(city: 'Kyiv').pluck(:name)).to contain_exactly('Sirius', 'Rex')
    end

    it 'filters by age range' do
      expect(described_class.filters(age_from: 3, age_to: 5).pluck(:name)).to contain_exactly('Albus', 'Sirius')
    end

    it 'filters by combined breed, city, and age range' do
      expect(described_class.filters(breed: 'Labrador', city: 'Lviv', age_from: 2, age_to: 4).pluck(:name)).to eq(['Albus'])
    end
  end

  describe '.current_user' do
    it 'returns dogs for a user id' do
      user = create(:user)
      dog = create(:dog, user: user)
      create(:dog)

      expect(described_class.current_user(user.id)).to eq([dog])
    end
  end
end
