require 'rails_helper'

RSpec.describe 'User registration', type: :feature do

  before(:each) { visit new_user_registration_path }

  scenario 'valid inputs' do    
    expect(page).to have_content('Sign up')
    fill_in "Email", with: 'tst@example.com'
    fill_in "First name", with: 'asd'
    fill_in "Last name", with: 'asd'
    fill_in "Password", with: 'asdasd'
    fill_in "Password confirmation", with: 'asdasd'
    click_on 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('My list')
  end

  feature "invalid inputs" do
    scenario "empty email" do  
      fill_in "Email", with: ''
      fill_in "First name", with: 'asd'
      fill_in "Last name", with: 'asd'
      fill_in "Password", with: 'asdasd'
      fill_in "Password confirmation", with: 'asdasd'
      click_on 'Sign up'
      expect(page).to have_content("Email can't be blank")
    end

    scenario "empty First Name" do  
      fill_in "Email", with: 'qwe@qwe.com'
      fill_in "First name", with: ''
      fill_in "Last name", with: 'asd'
      fill_in "Password", with: 'asdasd'
      fill_in "Password confirmation", with: 'asdasd'
      click_on 'Sign up'
      expect(page).to have_content("First name can't be blank")
    end

    scenario "invalid short password" do  
      fill_in "Email", with: 'qwe@qwe.com'
      fill_in "First name", with: 'asd'
      fill_in "Last name", with: 'asd'
      fill_in "Password", with: 'asd'
      fill_in "Password confirmation", with: 'asd'
      click_on 'Sign up'
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
    end

    scenario "invalid password confirmation" do  
      fill_in "Email", with: 'qwe@qwe.com'
      fill_in "First name", with: 'asd'
      fill_in "Last name", with: 'asd'
      fill_in "Password", with: 'asdasd'
      fill_in "Password confirmation", with: 'asdddd'
      click_on 'Sign up'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end