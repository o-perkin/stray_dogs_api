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
      breed = create(:breed)
      city = create(:city)
      age = create(:age)
      dog = create(:dog, name: "Albus", breed_id: breed.id, city_id: city.id, age_id: age.id)
      get "/api/v1/dogs?breed_id=#{breed.id}&city_id=#{city.id}&age_from=#{age.id - 1}&age_to=#{age.id + 1}"
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
      age = create(:age, id: "1")
      dog = create(:dog, age_id: age.id)
      get "/api/v1/dogs?sort=age_id&direction=asc"
      expect(response).to have_http_status(200)
      expect(json['data'][0]["age_id"]).to eq(1)
      get "/api/v1/dogs?sort=age_id&direction=desc"
      expect(json['data'][0]["age_id"]).to_not eq(1)
    end
  end

  describe "Get/api/v1/my_list" do 
    it 'sends error that you need to login first' do      
      get '/api/v1/my_list'
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end

    it 'sends 1 dog' do 
      user = create(:user)
      sign_in user 
      dog = create(:dog, user_id: user.id)   
      get '/api/v1/my_list'
      expect(response).to have_http_status(200)
      expect(json['data'].length).to eq(1)
      expect(json['data'][0]["name"]).to eq(dog.name)
    end
  end

  describe "Get/api/v1/dogs/:id" do 
    it 'sends 1 dog' do 
      dog = create(:dog)   
      get "/api/v1/dogs/#{dog.id}"
      expect(response).to have_http_status(200)
      expect(json['data']["dog"]["name"]).to eq(dog.name)
    end
  end

  describe "POST/api/v1/dogs" do 

    before(:each) do
      @user = create(:user)
      @breed = create(:breed)
      @city = create(:city)
      @age = create(:age)      
    end

    it 'sends error that you need to login first' do 
      post "/api/v1/dogs", params: {dog: {name: "Fred", breed_id: @breed.id, city_id: @city.id, age_id: @age.id}}
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end

    it 'sends created dog info if all params exist' do   
      sign_in @user    
      post "/api/v1/dogs", params: {dog: {name: "Fred", breed_id: @breed.id, city_id: @city.id, age_id: @age.id}}
      expect(response).to have_http_status(201)
      expect(json["data"]["name"]).to eq("Fred")
    end

    it 'sends error if not all parameters exist' do 
      sign_in @user
      post "/api/v1/dogs", params: {dog: {name: "", breed_id: @breed.id, city_id: @city.id, age_id: @age.id}}
      expect(response).to have_http_status(422)
      expect(json["data"]["name"]).to eq(["can't be blank"])
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