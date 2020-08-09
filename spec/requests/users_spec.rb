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
    end
  end

  context "PUT #actions" do
    describe "PUT /" do
      it "sends notice that account has been updated" do
        sign_in user
        put user_registration_path, params: { user: {email: "abc@cd.as", current_password: "asdasd", first_name: "aaab", last_name: "bbba"}, format: :json}
        expect(response).to have_http_status(204)
      end
    end
  end
=begin
  context "DELETE #actions" do
    
    before(:each) {sign_in user}

    describe "DELETE /logout" do
      it "should redirect to home page with notice that user Signed out" do
        delete destroy_user_session_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response).to render_template(:home)
        expect(response.body).to include("Signed out successfully.")  
      end
    end

    describe "DELETE /" do
      it "should redirect to home page with notice that account has been cancelled" do
        delete user_registration_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response).to render_template(:home)
        expect(response.body).to include("Bye! Your account has been successfully cancelled. We hope to see you again soon.")  
      end
    end
  end
=end
end