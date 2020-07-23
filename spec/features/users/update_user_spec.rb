require 'rails_helper'

RSpec.describe 'Update User', type: :feature do

  before(:each) do
    user = create(:user)
    sign_in user
    visit edit_user_registration_path
  end

  scenario 'valid inputs' do
    fill_in "Email", with: 'tst@example.com'
    fill_in "First name", with: 'asd'
    fill_in "Last name", with: 'asd'
    fill_in "Password", with: 'asdasdasd'
    fill_in "Password confirmation", with: 'asdasdasd'
    fill_in "Current password", with: 'asdasd'
    click_on 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
    expect(page).to have_content("The Dogs That Don't Belong to Anyone")
  end

  feature 'invalid inputs' do
    scenario 'empty email' do
      fill_in "Email", with: ''
      fill_in "First name", with: 'asd'
      fill_in "Last name", with: 'asd'
      fill_in "Password", with: 'asdasdasd'
      fill_in "Password confirmation", with: 'asdasdasd'
      fill_in "Current password", with: 'asdasd'
      click_on 'Update'
      expect(page).to have_content("Email can't be blank")
    end

    scenario 'empty name' do
      fill_in "Email", with: 'asdasd@asdasd.com'
      fill_in "First name", with: ''
      fill_in "Last name", with: ''
      fill_in "Password", with: 'asdasdasd'
      fill_in "Password confirmation", with: 'asdasdasd'
      fill_in "Current password", with: 'asdasd'
      click_on 'Update'
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
    end

    scenario 'too short password' do
      fill_in "Email", with: 'asdasd@asdasd.com'
      fill_in "First name", with: 'asd'
      fill_in "Last name", with: 'asd'
      fill_in "Password", with: 'asd'
      fill_in "Password confirmation", with: 'asd'
      fill_in "Current password", with: 'asdasd'
      click_on 'Update'
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
    end

    scenario 'invalid password confirmation' do
      fill_in "Email", with: 'asdasd@asdasd.com'
      fill_in "First name", with: 'asd'
      fill_in "Last name", with: 'asd'
      fill_in "Password", with: 'asdasd'
      fill_in "Password confirmation", with: 'asdasdasd'
      fill_in "Current password", with: 'asdasd'
      click_on 'Update'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario 'invalid current password' do
      fill_in "Email", with: 'asdasd@asdasd.com'
      fill_in "First name", with: 'asd'
      fill_in "Last name", with: 'asd'
      fill_in "Password", with: 'asdasdasd'
      fill_in "Password confirmation", with: 'asdasdasd'
      fill_in "Current password", with: 'asdasdas'
      click_on 'Update'
      expect(page).to have_content("Current password is invalid")
    end
  end
end