require 'rails_helper'

RSpec.describe Favorite, :type => :model do  


  let!(:favorite) { create(:favorite) }

  it "is valid with valid attributes" do    
    expect(favorite).to be_valid
  end

  it "is not valid without dog" do
    favorite.dog_id = nil
    expect(favorite).to_not be_valid
  end

  it "is not valid without user" do
    favorite.user_id = nil
    expect(favorite).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:dog) }
    it { should belong_to(:user) }
  end
end