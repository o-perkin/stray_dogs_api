require 'rails_helper'

RSpec.describe 'Updating a dog', type: :feature do

  feature "Regular User" do

    let!(:user) { create(:user) }
    let!(:dog) { create(:dog, user_id: user.id) }
    before(:each) do
      sign_in user
      visit my_list_path
      click_on "Edit", match: :first
    end

    scenario 'valid inputs' do   
      expect(page).to have_content('Editing Dog') 
      fill_in 'Name', with: 'Charlie'
      click_on 'Submit'
      visit dog_path(id: dog.id)
      expect(page).to have_content('Charlie')
    end

    scenario 'invalid inputs' do
      fill_in 'Name', with: ''
      click_on 'Submit'
      expect(page).to have_content("Name can't be blank")
    end
  end

  scenario 'Regular user visit main list and there is not Edit buttons' do
    dog = create(:dog)
    user = create(:user)
    sign_in user
    visit dogs_path
    expect(page).to have_no_content("Edit")
  end

  let(:regular_user) { create(:user) }
  let(:admin) { create(:user, roles: "site_admin") }

  before do
    @dog = create(:dog, name: "Kate", user_id: regular_user.id)
    sign_in admin
    visit dogs_path
  end 

  feature "Admin" do
    
    scenario 'sees the edit button on main list page' do  
      expect(page).to have_content('Edit')
    end

    scenario "сan edit another user's dog" do      
      expect(page).to have_content('Kate')
      click_on "Edit", match: :first
      expect(page).to have_content('Editing Dog')
    end

    scenario 'can edit the dog from dogs show page' do
      visit dog_path(id: @dog.id)  
      expect(page).to have_content('Kate')
      click_on "Edit information"
      expect(page).to have_content('Editing Dog')
    end
  end
end