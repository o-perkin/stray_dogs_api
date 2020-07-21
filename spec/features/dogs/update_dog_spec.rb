require 'rails_helper'

RSpec.describe 'Updating a dog', type: :feature do

  feature "Regular User" do

    let!(:user) { create(:user) }
    let!(:dog) { create(:dog, user_id: user.id) }
    before(:each) do
      sign_in user
    end

    scenario 'valid inputs' do    
      visit edit_dog_path(id: dog.id)
      fill_in 'Name', with: 'Charlie'
      click_on 'Submit'
      visit dog_path(id: dog.id)
      expect(page).to have_content('Charlie')
    end

    scenario 'invalid inputs' do
      visit edit_dog_path(id: dog.id)
      fill_in 'Name', with: ''
      click_on 'Submit'
      expect(page).to have_content("Name can't be blank")
    end
  end

  scenario 'Regular user visit main list and there is not Edit button' do
    dog = create(:dog)
    user = create(:user)
    sign_in user
    visit dogs_path
    expect(page).to have_no_content("Edit")
  end

  feature "Admin" do
    let!(:user) { create(:user, roles: "site_admin") }
    let!(:dog) { create(:dog) }
    before(:each) do
      sign_in user
      visit dogs_path
    end

    scenario 'valid inputs' do    
      dog.user_id = user.id
      click_on "Edit", match: :first
      fill_in 'Name', with: 'Charlie'
      click_on 'Submit'
      visit dog_path(id: dog.id)
      expect(page).to have_content('Charlie')
    end

    scenario 'invalid inputs' do
      dog.user_id = user.id
      click_on "Edit", match: :first
      fill_in 'Name', with: ''
      click_on 'Submit'
      expect(page).to have_content("Name can't be blank")
    end

    scenario 'updates any other dog' do
      click_on "Edit", match: :first
      expect(page).to have_content("Editing Dog")
    end
  end
end