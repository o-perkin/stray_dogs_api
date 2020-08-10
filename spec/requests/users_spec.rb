require 'rails_helper'

RSpec.describe "Users", type: :request do

  let!(:user) {create(:user)}

  context "POST #actions" do
    describe "POST /login" do
      it "sends user info" do
        post "/login", params: { user: {email: user.email, password: user.password}} 
        expect(response).to have_http_status(200)       
        expect(json["email"]).to include(user.email)  
      end

      it "sends invalid email or password" do
        post "/login", params: { user: {email: "qwe@asd.com", password: "asdasd"}}  
        expect(response).to have_http_status(401)  
        expect(response.body).to include("Invalid Email or password.")  
      end
    end

    describe "POST /" do
      it "sends new users info" do 
        post "/", params: { user: {email: "ab@cd.as", password: "asdasd", password_confirmation: "asdasd", first_name: "aaa", last_name: "bbb"}, format: :json}
        expect(response).to have_http_status(201)
        expect(json["email"]).to include("ab@cd.as")  
      end

      it "sends error when email is already taken or password confirmation is wrong" do 
        create(:user, email: "asdasd@gmail.com")
        post "/", params: { user: {email: "asdasd@gmail.com", password: "asdasd", password_confirmation: "asdasdd", first_name: "aaa", last_name: "bbb"}, format: :json}
        expect(response).to have_http_status(422)
        expect(json["errors"]["email"]).to include("has already been taken")  
        expect(json["errors"]["password_confirmation"]).to include("doesn't match Password")  
      end
    end
  end

  context "PUT #actions" do
    describe "PUT /" do
      it "sends notice that account has been updated" do
        sign_in user
        put user_registration_path, params: { user: {email: "abc@cd.as", current_password: "asdasd", first_name: "aaab", last_name: "bbba"}, format: :json}
        expect(response).to have_http_status(204)
      end

      it "sends notice that you need login" do
        put user_registration_path, params: { user: {email: "abc@cd.as", current_password: "asdasd", first_name: "aaab", last_name: "bbba"}, format: :json}
        expect(response).to have_http_status(401)
        expect(response.body).to include("You need to sign in or sign up before continuing.")
      end

      it "sends error when email is already taken or password confirmation is wrong" do 
        create(:user, email: "asdasd@gmail.com")
        post "/", params: { user: {email: "asdasd@gmail.com", password: "asdasd", password_confirmation: "asdasdd", current_password: "asdasd", first_name: "aaa", last_name: "bbb"}, format: :json}
        expect(response).to have_http_status(422)
        expect(json["errors"]["email"]).to include("has already been taken")  
        expect(json["errors"]["password_confirmation"]).to include("doesn't match Password")  
      end
    end
  end

  context "DELETE #actions" do

    describe "DELETE /logout" do

      it "sends status ok" do
        sign_in user
        delete '/logout'
        expect(response).to have_http_status(200)    
      end
    end

    describe "DELETE /" do
      it "sends 401 status if user not logged in" do
        delete '/'
        expect(response).to have_http_status(401)   
        expect(response.body).to include("You need to sign in or sign up before continuing.")   
      end

      it "sends status 204" do
        sign_in user
        delete '/'
        expect(response).to have_http_status(200)   
        expect(json["message"]).to include("User deleted")   
      end
    end
  end

end