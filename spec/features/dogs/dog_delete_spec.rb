require 'rails_helper'

RSpec.describe 'Deleting a dog', type: :feature do
  feature "Regular User" do
    scenario 'success' do
      user = create(:user)
      sign_in user
      dog = create(:dog, name: "Alexandro", user_id: user.id)
      visit dogs_path
      expect(page).to have_content('Alexandro')
      visit my_list_path
      expect(page).to have_content('Alexandro')
      click_on 'Delete'
      expect(page).not_to have_content('Alexandro')
    end
  end
  feature "Admin" do
    scenario 'success' do
      user = create(:user, roles: "site_admin")
      sign_in user
      dog = create(:dog, name: "Vasya", user_id: user.id)
      visit dogs_path
      expect(page).to have_content('Vasya')
      click_on 'Delete', match: :first
      expect(page).not_to have_content('Vasya')
    end
  end

end