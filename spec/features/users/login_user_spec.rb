require 'rails_helper'

RSpec.describe 'Login a User', type: :feature do

  let!(:user) { create(:user, email: "asd@example.com", password: "asdasd") }

  scenario 'valid inputs' do
    visit new_user_session_path
    expect(page).to have_content('Login')
    fill_in "Email", with: 'asd@example.com'
    fill_in "Password", with: 'asdasd'
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('My list')
  end

  feature "invalid inputs" do

    scenario 'invalid password' do
      visit new_user_session_path
      expect(page).to have_content('Login')
      fill_in "Email", with: 'asd@example.com'
      fill_in "Password", with: 'asdasdd'
      click_on 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    scenario 'invalid email' do
      visit new_user_session_path
      expect(page).to have_content('Login')
      fill_in "Email", with: 'asdd@example.com'
      fill_in "Password", with: 'asdasd'
      click_on 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end
  end

  scenario 'logout' do
    sign_in user
    visit root_path
    click_on 'Logout'    
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_no_content('My list')
  end
end