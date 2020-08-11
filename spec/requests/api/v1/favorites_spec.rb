require 'rails_helper'

RSpec.describe "Favorites", type: :request do

  let(:user) { create(:user) }
  let(:dog) { create(:dog) }
  
  describe "GET #update" do
    it "sends status ok and message that favorite updated" do
      sign_in user
      get "/api/v1/favorites/update?dog=#{dog.id}"
      expect(response).to have_http_status(200)
      expect(json["message"]).to eq("Favorite Updated")
    end

    it "sends notice that you need to login" do
      get "/api/v1/favorites/update?dog=#{dog.id}"
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end
  end
end