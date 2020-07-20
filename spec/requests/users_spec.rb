require 'rails_helper'

RSpec.describe "Users", type: :request do

  let!(:user) {create(:user)}

  context "GET #actions" do
    describe "GET /login" do

      it "should render login page" do
        get new_user_session_path
        expect(response).to render_template("sessions/new")
      end

      it "should render home page with notice if the user is logged in" do
        sign_in user
        get new_user_session_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response).to render_template(:home)
        expect(response.body).to include("You are already signed in.")
      end
    end

    describe "GET /password/new" do

      it "should render forgot password page" do
        get new_user_password_path
        expect(response).to render_template("passwords/new")
      end

      it "should render home page with notice if the user is logged in" do
        sign_in user
        get new_user_password_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response).to render_template(:home)
        expect(response.body).to include("You are already signed in.")
      end
    end

    describe "GET /register" do

      it "should render register page" do
        get new_user_registration_path
        expect(response).to render_template("registrations/new")
      end

      it "should render home page with notice if the user is logged in" do
        sign_in user
        get new_user_registration_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response).to render_template(:home)
        expect(response.body).to include("You are already signed in.")
      end
    end

    describe "GET /cancel" do

      it "should render redirect to register page if the user is not logged in" do
        get cancel_user_registration_path
        expect(response).to redirect_to(new_user_registration_path)

        follow_redirect!
        expect(response).to render_template("registrations/new")
      end

      it "should render home page with notice if the user is logged in" do
        sign_in user
        get cancel_user_registration_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response).to render_template(:home)
        expect(response.body).to include("You are already signed in.")
      end
    end

    describe "GET /edit" do

      it "should render edit user info page if the user is logged in" do
        sign_in user
        get edit_user_registration_path
        expect(response).to render_template("registrations/edit")
      end

      it "should render home page with notice if the user is not logged in" do
        get edit_user_registration_path
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response).to render_template("sessions/new")
        expect(response.body).to include("You need to sign in or sign up before continuing.")
      end
    end
  end

  context "POST #actions" do
    describe "POST /login" do
      it "should redirect to home page with notice that user Signed in" do
        post user_session_path, params: { user: {email: user.email, password: user.password}}
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response).to render_template(:home)
        expect(response.body).to include("Signed in successfully.")  
      end

      it "should render new session page with notice invalid email or password" do
        post user_session_path
        expect(response).to render_template("sessions/new")
        expect(response.body).to include("Invalid Email or password.")  
      end
    end

    describe "POST /" do
      it "should redirect to home page with notice that user Signed up" do
        post user_registration_path, params: { user: {email: "ab@cd.as", password: "asdasd", first_name: "aaa", last_name: "bbb"}}
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response).to render_template(:home)
        expect(response.body).to include("Welcome! You have signed up successfully.")  
      end
    end
  end

  context "PUT #actions" do
    describe "PUT /" do
      it "should redirect to home page with notice that account has been updated" do
        sign_in user
        put user_registration_path, params: { user: {email: "abc@cd.as", current_password: "asdasd", first_name: "aaab", last_name: "bbba"}}
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response).to render_template(:home)
        expect(response.body).to include("Your account has been updated successfully.")  
      end
    end
  end

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

end