require 'rails_helper'

RSpec.describe 'Cancel User Account', type: :feature do

  scenario 'success' do
    user = create(:user) 
    sign_in user 
    visit edit_user_registration_path    
    expect(page).to have_content('Edit User')
    click_on 'Cancel my account'
    expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
    expect(page).to have_no_content('My list')
  end
end