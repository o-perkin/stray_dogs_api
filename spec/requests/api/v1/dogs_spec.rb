require 'rails_helper'

RSpec.describe "Dogs", type: :request do
  describe "GET /api/v1/dogs" do
    before do
      create(:dog, name: "Albus", breed: "Labrador", city: "Lviv", age: "3")
      create(:dog, name: "Sirius", breed: "German Shepherd", city: "Kyiv", age: "5")
      create(:dog, name: "Rex", breed: "Labrador", city: "Kyiv", age: "7")
      create(:dog, name: "Lucky", breed: "Beagle", city: "Lviv", age: "2")
      create(:dog, name: "Bars", breed: "Poodle", city: "Dnipro", age: "9")
      create(:dog, name: "Molly", breed: "Bulldog", city: "Kharkiv", age: "4")
    end

    it 'returns HTTP 200 with no filters applied' do
      get '/api/v1/dogs'

      expect(response).to have_http_status(200)
      expect(json['status']).to eq('Success')
      expect(json['message']).to eq('Loaded dogs')
      expect(json['data'].length).to eq(5)
    end

    it 'filters by dog name search' do
      get '/api/v1/dogs', params: { search: 'siri' }

      expect(response).to have_http_status(200)
      expect(json['data'].map { |dog| dog['name'] }).to eq(['Sirius'])
    end

    it 'filters by breed' do
      get '/api/v1/dogs', params: { breed: 'Labrador' }

      expect(response).to have_http_status(200)
      expect(json['data'].map { |dog| dog['breed'] }.uniq).to eq(['Labrador'])
      expect(json['data'].map { |dog| dog['name'] }).to contain_exactly('Albus', 'Rex')
    end

    it 'filters by city' do
      get '/api/v1/dogs', params: { city: 'Kyiv' }

      expect(response).to have_http_status(200)
      expect(json['data'].map { |dog| dog['city'] }.uniq).to eq(['Kyiv'])
      expect(json['data'].map { |dog| dog['name'] }).to contain_exactly('Sirius', 'Rex')
    end

    it 'filters by age range' do
      get '/api/v1/dogs', params: { age_from: 3, age_to: 5 }

      expect(response).to have_http_status(200)
      expect(json['data'].map { |dog| dog['name'] }).to contain_exactly('Albus', 'Sirius', 'Molly')
    end

    it 'filters by combined breed, city, and age range' do
      get '/api/v1/dogs', params: { breed: 'Labrador', city: 'Lviv', age_from: 2, age_to: 4 }

      expect(response).to have_http_status(200)
      expect(json['data'].map { |dog| dog['name'] }).to eq(['Albus'])
    end

    it 'keeps sorting working with filters' do
      get '/api/v1/dogs', params: { city: 'Kyiv', sort: 'age', direction: 'asc' }

      expect(response).to have_http_status(200)
      expect(json['data'].map { |dog| dog['name'] }).to eq(['Sirius', 'Rex'])
    end

    it 'keeps pagination working with filters' do
      get '/api/v1/dogs', params: { page: 2 }

      expect(response).to have_http_status(200)
      expect(json['data'].length).to eq(1)
    end
  end

  describe "GET /api/v1/my_dogs" do
    it 'sends error that you need to login first' do
      get '/api/v1/my_dogs'
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end

    it 'sends 1 dog' do
      user = create(:user)
      sign_in user
      dog = create(:dog, user: user)
      get '/api/v1/my_dogs'
      expect(response).to have_http_status(200)
      expect(json['data']['dogs'].length).to eq(1)
      expect(json['data']['dogs'][0]["name"]).to eq(dog.name)
    end
  end

  describe "GET /api/v1/dogs/:id" do
    it 'sends 1 dog' do
      dog = create(:dog)
      get "/api/v1/dogs/#{dog.id}"
      expect(response).to have_http_status(200)
      expect(json['data']["dog"][0]["name"]).to eq(dog.name)
    end
  end

  describe "POST /api/v1/dogs" do
    let(:user) { create(:user) }
    let(:dog_params) { { dog: { name: "Fred", breed: "Labrador", city: "Lviv", age: "2" } } }

    it 'sends error that you need to login first' do
      post "/api/v1/dogs", params: dog_params
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end

    it 'sends created dog info if all params exist' do
      sign_in user
      post "/api/v1/dogs", params: dog_params
      expect(response).to have_http_status(201)
      expect(json["data"]["name"]).to eq("Fred")
    end

    it 'sends error if not all parameters exist' do
      sign_in user
      post "/api/v1/dogs", params: { dog: { name: "", breed: "Labrador", city: "Lviv", age: "2" } }
      expect(response).to have_http_status(422)
      expect(json["data"]["name"]).to eq(["can't be blank"])
    end
  end

  describe "PATCH /api/v1/dogs/:id" do
    it 'sends error that you need to login first' do
      dog = create(:dog)
      patch "/api/v1/dogs/#{dog.id}", params: { dog: { name: "Fred" } }
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end

    it 'sends updated dog info' do
      user = create(:user)
      dog = create(:dog, user: user)
      sign_in user
      patch "/api/v1/dogs/#{dog.id}", params: { dog: { name: "Vova" } }
      expect(response).to have_http_status(200)
      expect(json["data"]["name"]).to eq("Vova")
    end

    it 'sends access denied when try update someone else dog' do
      user = create(:user)
      dog = create(:dog)
      sign_in user
      patch "/api/v1/dogs/#{dog.id}", params: { dog: { name: "Vova" } }
      expect(response).to have_http_status(403)
      expect(json["message"]).to eq("Access denied")
    end
  end

  describe "DELETE /api/v1/dogs/:id" do
    it 'sends error that you need to login first' do
      dog = create(:dog)
      delete "/api/v1/dogs/#{dog.id}"
      expect(response).to have_http_status(401)
      expect(response.body).to eq("You need to sign in or sign up before continuing.")
    end

    it 'sends 200 status' do
      user = create(:user)
      dog = create(:dog, user: user)
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
