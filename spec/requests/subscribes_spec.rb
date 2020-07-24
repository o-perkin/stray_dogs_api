require 'rails_helper'

RSpec.describe "Subscribes", type: :request do

  let!(:user) { create(:user) }

  context "GET #actions" do
    describe "GET #index" do

      it "should redirect to login page if the user is not logged in" do
        get subscribes_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should render index template if the user is logged in" do
        sign_in user
        get subscribes_path
        expect(response).to render_template(:index)
      end
    end

    describe "GET #new" do

      it "should redirect to login page if the user is not logged in" do
        get new_subscribe_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should render new template if the user is logged in" do
        sign_in user
        get new_subscribe_path
        expect(response).to render_template(:new)
      end

      it "should render new template with notice if the user has already subscribed" do
        sign_in user
        create(:subscribe, user_id: user.id)
        get new_subscribe_path
        expect(response).to redirect_to(subscribes_path)
        follow_redirect!
        expect(response).to render_template(:index)
        expect(response.body).to include("You have alerady subscribed")
      end
    end

    let(:subscribe) { create(:subscribe, user_id: user.id) }

    describe "GET #edit" do
      it "should redirect to login page if the user is not logged in" do
        get edit_subscribe_path(subscribe.id)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should render edit template if the user is logged in" do
        sign_in user
        get edit_subscribe_path(subscribe.id)
        expect(response).to render_template(:edit)
      end     
    end
  end

  context "Post/PATCH requests" do

    describe "Post #create" do
      it "should redirect to subscribes page and render index template with notice" do
        sign_in user
        post subscribes_path, params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: "1", city_id: "1", age_from: "1", age_to: "2", _destroy: "false"}} } }
        
        expect(response).to redirect_to(subscribes_path)
        follow_redirect!

        expect(response).to render_template(:index)
        expect(response.body).to include("Subscribe was successfully created.")        
      end
    end

    describe "PATCH #update" do
      it "should redirect to subscribe page and render index template with notice" do
        sign_in user
        subscribe = create(:subscribe, user_id: user.id)
        patch subscribe_path(subscribe.id), params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: "2", city_id: "3", age_from: "1", age_to: "3", _destroy: "false"}} } }

        expect(response).to redirect_to(subscribes_path)
        follow_redirect!

        expect(response).to render_template(:index)
        expect(response.body).to include("Subscribe was successfully updated.")        
      end
    end
  end

  context "DELETE requests" do    

    describe "DELETE #destroy" do

      it "should render index with notice if user deleted subscribe" do
        sign_in user
        subscribe = create(:subscribe, user_id: user.id)
        delete subscribe_path(subscribe.id)
        expect(response).to redirect_to(subscribes_path)
        follow_redirect!

        expect(response).to render_template(:index)
        expect(response.body).to include("Subscribe was successfully destroyed.")       
      end
    end
  end
end

