require 'rails_helper'

RSpec.describe "Dogs", type: :request do

  context "Get requests" do 

    describe "GET root_path" do
      it "should render home template" do
        get root_path
        expect(response).to render_template(:home)
      end
    end

    describe "GET #index" do
      it "should render index_list template" do
        get dogs_path
        expect(response).to render_template(:_index_list)
      end
    end

    describe "GET #my_list" do
      it "should redirect to login page if the user is not logged in" do
        get my_list_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should render my_list template if the user is logged in" do
        user = create(:user)
        sign_in user
        get my_list_path
        expect(response).to render_template(:_my_list)
      end
    end

    describe "GET #favorites" do
      it "should redirect to login page if the user is not logged in" do
        get my_favorites_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should render favorites template if the user is logged in" do
        user = create(:user)
        sign_in user
        get my_favorites_path
        expect(response).to render_template(:favorites)
      end
    end

    describe "GET #new" do
      it "should redirect to login page if the user is not logged in" do
        get new_dog_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should render favorites template if the user is logged in" do
        user = create(:user)
        sign_in user
        get new_dog_path
        expect(response).to render_template(:new)
      end
    end

    let(:dog) { create(:dog) }

    describe "GET #edit" do
      it "should redirect to login page if the user is not logged in" do
        get edit_dog_path(dog.id)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should render favorites template if the user is logged in" do
        user = create(:user)
        sign_in user
        get edit_dog_path(dog.id)
        expect(response).to render_template(:edit)
      end
    end

    describe "GET #show" do
      it "should render show template" do
        dog = create(:dog)
        get dog_path(dog.id)
        expect(response).to render_template(:show)
      end
    end
  end

  context "Post/PATCH requests" do

    describe "Post #create" do
      it "should redirect to new dog show path and render show template with notice" do
        user = create(:user)
        sign_in user
        post dogs_path, params: { dog: { name: "Fred", breed_id: "1", city_id: "1", age_id: "1", description: "asdasd" } }

        expect(response).to redirect_to(assigns(:dog))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include("Dog was successfully created.")        
      end

      it "should render new template if not all parameters were specified" do
        user = create(:user)
        sign_in user
        post dogs_path, params: { dog: { name: "", breed_id: "1", city_id: "1", age_id: "1", description: "asdasd" } }

        expect(response).to render_template(:new)      
        expect(response.body).to include("error prohibited this dog from being saved")        
      end
    end

    describe "PATCH #update" do
      it "should redirect to new dog show path and render show template with notice" do
        user = create(:user)
        sign_in user
        dog = create(:dog)
        patch dog_path(dog.id), params: { dog: { name: "Fred", breed_id: "1", city_id: "1", age_id: "1", description: "asdasd" } }

        expect(response).to redirect_to(assigns(:dog))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include("Dog was successfully updated.")        
      end
    end

    it "should render new template if not all parameters were specified" do
      user = create(:user)
      sign_in user
      dog = create(:dog)
      patch dog_path(dog.id), params: { dog: { name: "asd", breed_id: "", city_id: "1", age_id: "1", description: "asdasd" } }

      expect(response).to render_template(:edit)             
    end
  end

  context "DELETE requests" do

    describe "DELETE #destroy" do

      it "should redirect to dogs path and render index with notice if user tried to delete dog drom main list" do
        user = create(:user)
        sign_in user
        dog = create(:dog)
        get dogs_path
        delete dog_path(dog.id)
        expect(response).to redirect_to(dogs_path)
        follow_redirect!

        expect(response).to render_template(:index)
        expect(response.body).to include("Dog was successfully destroyed.")       
      end
    end
  end
end 
