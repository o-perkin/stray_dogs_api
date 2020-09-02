require 'rails_helper'

RSpec.describe "Dogs", type: :request do

  describe "Get/api/v1/dogs" do 

    before(:each) { create_list(:dog, 10) }

    it 'sends 5 dogs on first page' do      
      get '/api/v1/dogs'
      expect(response).to have_http_status(200)
      expect(json['data'].length).to eq(5)
    end

    it 'sends 5 dogs on second page' do
      get '/api/v1/dogs?page=2'
      expect(response).to have_http_status(200)
      expect(json['data'].length).to eq(5)
    end

    it 'sends 0 dogs on 7 page' do
      get '/api/v1/dogs?page=7'
      expect(response).to have_http_status(200)
      expect(json['data'].length).to eq(0)
    end

    it 'sends dog that fits the filters parameters' do
      dog = create(:dog, name: "Albus", breed: 4, city: 5, age: 3)
      get "/api/v1/dogs?breed=4&city=5&age_from=2&age_to=4"
      expect(response).to have_http_status(200)
      expect(json['data'].length).to eq(1)
      expect(json['data'][0]["name"]).to eq("Albus")
    end

    it 'sends dog that fits the search parameter' do
      dog = create(:dog, name: "Sivirus")
      get "/api/v1/dogs?search=Sivirus"
      expect(response).to have_http_status(200)
      expect(json['data'].length).to eq(1)
      expect(json['data'][0]["name"]).to eq("Sivirus")
    end

    it 'sends dog that fits the sort parameters' do
      dog = create(:dog, age: 1)
      get "/api/v1/dogs?sort=age&direction=asc"
      expect(response).to have_http_status(200)
      expect(json['data'][0]["age"]).to eq('1')
      get "/api/v1/dogs?sort=age&direction=desc"
      expect(json['data'][0]["age"]).to_not eq('1')
    end
  end

  describe "Get/api/v1/my_dogs" do 
    it 'sends error that you need to login first' do      
      get '/api/v1/my_dogs'
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end

    it 'sends 1 dog' do 
      user = create(:user)
      sign_in user 
      dog = create(:dog, user_id: user.id)   
      get '/api/v1/my_dogs'
      expect(response).to have_http_status(200)
      expect(json['data']['dogs'].length).to eq(1)
      expect(json['data']['dogs'][0]["name"]).to eq(dog.name)
    end
  end

  describe "Get/api/v1/dogs/:id" do 
    it 'sends 1 dog' do 
      dog = create(:dog)   
      get "/api/v1/dogs/#{dog.id}"
      expect(response).to have_http_status(200)
      expect(json['data']["dog"][0]["name"]).to eq(dog.name)
    end
  end

  describe "POST/api/v1/dogs" do 

    before(:each) do
      @user = create(:user)   
    end

    it 'sends error that you need to login first' do 
      post "/api/v1/dogs", params: {dog: {name: "Fred", breed: 2, city_id: 3, age: 4}}
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end

    it 'sends created dog info if all params exist' do   
      sign_in @user  
      headers = { "CONTENT_TYPE" => "application/json" }  
      post "/api/v1/dogs", params: '{"dog": {"name": "Fred", "breed": 3, "city": 2, "age": 1}}', headers: headers
      expect(response).to have_http_status(201)
      expect(json["data"]["name"]).to eq("Fred")
    end

    it 'sends error if not all parameters exist' do 
      sign_in @user
      post "/api/v1/dogs", params: {dog: {name: "", breed: 5, city: 2, age: 4}}
      expect(response).to have_http_status(422)
    end
  end

  describe "PATCH/api/v1/dogs/:id" do 
    it 'sends error that you need to login first' do 
      dog = create(:dog)
      patch "/api/v1/dogs/#{dog.id}", params: {dog: {name: "Fred"}}
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end

    it 'sends updated dog info' do 
      user = create(:user)
      dog = create(:dog, user_id: user.id)
      sign_in user
      patch "/api/v1/dogs/#{dog.id}", params: {dog: {name: "Vova"}}
      expect(response).to have_http_status(200)
      expect(json["data"]["name"]).to eq("Vova")
    end

    it 'sends access denied when try update someone else dog' do 
      user = create(:user)
      dog = create(:dog)
      sign_in user
      patch "/api/v1/dogs/#{dog.id}", params: {dog: {name: "Vova"}}
      expect(response).to have_http_status(403)
      expect(json["message"]).to eq("Access denied")
    end
  end

  describe "DELETE/api/v1/dogs/:id" do
    it 'sends error that you need to login first' do 
      dog = create(:dog)
      delete "/api/v1/dogs/#{dog.id}"
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end

    it 'sends 200 status' do 
      user = create(:user)
      dog = create(:dog, user_id: user.id)
      sign_in user
      delete "/api/v1/dogs/#{dog.id}"
      expect(response).to have_http_status(200)
      expect(json["message"]).to eq("Deleted a dog")
    end

    it 'sends access denied when try delete someone else dog' do 
      user = create(:user)
      dog = create(:dog)
      sign_in user
      delete "/api/v1/dogs/#{dog.id}"
      expect(response).to have_http_status(403)
      expect(json["message"]).to eq("Access denied")
    end
  end
end