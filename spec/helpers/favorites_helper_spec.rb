require "rails_helper"

RSpec.describe FavoritesHelper, type: :helper do
  describe ".favorite_text_for_show" do
    it "returns Remove from favorites if @favorite_exists == true" do
      @favorite_exists = true  
      expect(favorite_text_for_show).to eq("Remove from favorites")
    end

    it "returns Remove from favorites if @favorite_exists == true" do
      @favorite_exists = false  
      expect(favorite_text_for_show).to eq("Add to favorites")
    end
  end

  describe ".favorite_text_for_list" do

    let!(:user) { create(:user, email: "test1@gmail.com", password: "asdasd", first_name: "Name", last_name: "Last") }
    
    it "returns Add to favorites if the user hasn't a specific dog" do      
      expect(favorite_text_for_list(user, 1)).to eq("Add to favorites")
    end

    it "returns Remove from favorites if the user has a specific dog" do  
    user.favorites.create({dog_id: "1", user_id: "1"}) 
      expect(favorite_text_for_list(user, 1)).to eq("Remove from favorites")
    end
  end
end