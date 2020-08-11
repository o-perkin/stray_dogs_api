require 'rails_helper'

RSpec.describe "Subscribes", type: :request do

  let!(:user) { create(:user) }

  context "GET #actions" do
    describe "GET /api/v1/subscribes" do

      it "sends notice that you need to login" do
        get '/api/v1/subscribes'
        expect(response).to have_http_status(401)
        expect(response.body).to eq("You need to sign in or sign up before continuing.")
      end

      it "sends status ok and message lodaded subscribe" do
        sign_in user
        get '/api/v1/subscribes'
        expect(response).to have_http_status(200)
        expect(json['message']).to eq("Loaded subscribe")
      end
    end
  end

  context "Post/PATCH requests" do

    describe "Post /api/v1/subscribes" do
      it "sends status ok and new subscribe info" do
        breed = create(:breed)
        city = create(:city)
        sign_in user
        post '/api/v1/subscribes', params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: breed.id, city_id: city.id, age_from: "1", age_to: "2", _destroy: "false"}} } }
        
        expect(response).to have_http_status(200)
        expect(json['message']).to eq("Subscribe created")       
        expect(json['data'][0]["subscribe_id"]).to eq(user.subscribe.id)       
      end

      it "sends notice that you need to login" do
        breed = create(:breed)
        city = create(:city)
        post '/api/v1/subscribes', params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: breed.id, city_id: city.id, age_from: "1", age_to: "2", _destroy: "false"}} } }
        
        expect(response).to have_http_status(401)
        expect(response.body).to eq("You need to sign in or sign up before continuing.") 
      end

      it "sends status 422 and error that you've already subscribed" do
        breed = create(:breed)
        city = create(:city)
        sign_in user
        post '/api/v1/subscribes', params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: breed.id, city_id: city.id, age_from: "1", age_to: "2", _destroy: "false"}} } }
        expect(response).to have_http_status(200)
        sign_in user
        post '/api/v1/subscribes', params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: breed.id, city_id: city.id, age_from: "2", age_to: "4", _destroy: "false"}} } }
        
        expect(response).to have_http_status(422)
        expect(json['message']).to eq("Subscribe not saved")       
        expect(json['data']['user_id'][0]).to eq("You've already subscribed!")       
      end

      it "ends error when age_to less than age_from" do
        breed = create(:breed)
        city = create(:city)
        sign_in user
        post '/api/v1/subscribes', params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: breed.id, city_id: city.id, age_from: "2", age_to: "1", _destroy: "false"}} } }
        
        expect(response).to have_http_status(422)
        expect(json['message']).to eq("Subscribe not saved")
        expect(json['data']["subscriptions.age_to"]).to eq(["must be greater than or equal to 2"])    
      end
    end
  
    describe "PATCH /api/v1/subscribes" do
      it "sends status ok and updated subscribe's info" do
        breed = create(:breed)
        city = create(:city)
        sign_in user
        subscribe = create(:subscribe, user_id: user.id)
        patch "/api/v1/subscribes/#{subscribe.id}", params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: breed.id, city_id: city.id, age_from: "1", age_to: "3", _destroy: "false"}} } }
        
        expect(response).to have_http_status(200)
        expect(json['message']).to eq("Subscribe updated")
        expect(json['data'].last["breed_id"]).to eq(breed.id)        
      end

      it "sends notice that you need to login" do
        breed = create(:breed)
        city = create(:city)
        subscribe = create(:subscribe, user_id: user.id)
        patch "/api/v1/subscribes/#{subscribe.id}", params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: breed.id, city_id: city.id, age_from: "1", age_to: "3", _destroy: "false"}} } }
        
        expect(response).to have_http_status(401)
        expect(response.body).to eq("You need to sign in or sign up before continuing.")     
      end

      it "sends error when one of params are empty" do
        breed = create(:breed)
        city = create(:city)
        sign_in user
        subscribe = create(:subscribe, user_id: user.id)
        patch "/api/v1/subscribes/#{subscribe.id}", params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: "", city_id: city.id, age_from: "1", age_to: "3", _destroy: "false"}} } }
        
        expect(response).to have_http_status(422)
        expect(json['message']).to eq("Subscribe not updated")
        expect(json['data']["subscriptions.breed_id"]).to eq(["can't be blank"])        
      end

      it "sends error when age_to less than age_from" do
        breed = create(:breed)
        city = create(:city)
        sign_in user
        subscribe = create(:subscribe, user_id: user.id)
        patch "/api/v1/subscribes/#{subscribe.id}", params: { subscribe: { subscriptions_attributes: {"0" => {breed_id: "1", city_id: city.id, age_from: "2", age_to: "1", _destroy: "false"}} } }
        
        expect(response).to have_http_status(422)
        expect(json['message']).to eq("Subscribe not updated")
        expect(json['data']["subscriptions.age_to"]).to eq(["must be greater than or equal to 2"])        
      end
    end
  end

  context "DELETE requests" do    

    describe "DELETE /api/v1/subscribes" do

      it "sends status ok and subscribe deleted message" do
        sign_in user
        subscribe = create(:subscribe, user_id: user.id)
        delete "/api/v1/subscribes/#{subscribe.id}"
               
        expect(response).to have_http_status(200)
        expect(json['message']).to eq("Subscribe deleted")     
      end

      it "sends notice that you need to login" do
        subscribe = create(:subscribe, user_id: user.id)
        delete "/api/v1/subscribes/#{subscribe.id}"
               
        expect(response).to have_http_status(401)
        expect(response.body).to eq("You need to sign in or sign up before continuing.")  
      end
    end
  end

end

