require 'rails_helper'

RSpec.describe "Dogs", type: :request do

  let!(:dog) { create(:dog) }
  let!(:user) { create(:user) }

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
        sign_in user
        get new_dog_path
        expect(response).to render_template(:new)
      end
    end

    describe "GET #edit" do
      it "should redirect to login page if the user is not logged in" do
        get edit_dog_path(dog.id)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "should render edit template if the user is logged in" do
        sign_in user
        get edit_dog_path(dog.id)
        expect(response).to render_template(:edit)
      end

      it "should render edit template with notice that not enough permissions" do
        user2 = create(:user, id: "12")
        dog2 = create(:dog, user_id: "12")
        sign_in user
        get edit_dog_path(dog2.id)
        expect(response).to render_template(:edit)
        expect(response.body).to include("Not enough permissions to view page")
      end
    end

    describe "GET #show" do
      it "should render show template" do
        get dog_path(dog.id)
        expect(response).to render_template(:show)
      end
    end
  end

  context "Post/PATCH requests" do

    describe "Post #create" do
      it "should redirect to new dog show path and render show template with notice and send email" do
        sign_in user
        post dogs_path, params: { dog: { name: "Fred", breed_id: "1", city_id: "1", age_id: "1", description: "asdasd" } }       
        
        expect(response).to redirect_to(assigns(:dog))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include("Dog was successfully created.")   

      end      

      it "should render new template if not all parameters were specified" do
        sign_in user
        post dogs_path, params: { dog: { name: "", breed_id: "1", city_id: "1", age_id: "1", description: "asdasd" } }

        expect(response).to render_template(:new)      
        expect(response.body).to include("Name can&#39;t be blank")        
      end
    end

    describe "PATCH #update" do
      it "should redirect to new dog show path and render show template with notice" do
        sign_in user
        patch dog_path(dog.id), params: { dog: { name: "Fred", breed_id: "1", city_id: "1", age_id: "1", description: "asdasd" } }

        expect(response).to redirect_to(assigns(:dog))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include("Dog was successfully updated.")        
      end
    end

    it "should render new template if not all parameters were specified" do
      sign_in user
      patch dog_path(dog.id), params: { dog: { name: "asd", breed_id: "", city_id: "1", age_id: "1", description: "asdasd" } }

      expect(response).to render_template(:edit)             
    end
  end

  context "DELETE requests" do    

    describe "DELETE #destroy" do

      it "should render index with notice if user deleted dog" do
        sign_in user
        delete dog_path(dog.id)
        expect(response).to redirect_to(dogs_path)
        follow_redirect!

        expect(response).to render_template(:index)
        expect(response.body).to include("Dog was successfully destroyed.")       
      end
    end
  end
end 
