require 'rails_helper'

RSpec.describe "Favorites", type: :request do

  let(:user) { create(:user) }
  let(:dog) { create(:dog) }
  before { sign_in user }

  context "FavoritesController#actions" do
    describe "GET #update" do
      it "should call js view file when user clickes on favorite button" do
        get favorites_update_path(dog: dog), xhr: true
        expect(response.content_type).to eq('text/javascript; charset=utf-8')
      end
    end

    describe "DELETE #destroy" do
      it "should render favorites with notice if user deleted dog from favorites" do

        get favorites_update_path(dog: dog), xhr: true
        expect(response.content_type).to eq('text/javascript; charset=utf-8')

        delete favorite_path(user.favorites.last.id)
        
        expect(response).to redirect_to(my_favorites_path)
        follow_redirect!

        expect(response).to render_template(:favorites)
        expect(response.body).to include("Dog was successfully destroyed.")       
      end
    end
  end
end