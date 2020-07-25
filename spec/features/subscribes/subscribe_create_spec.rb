require 'rails_helper'

RSpec.describe 'Creating a subscribe', type: :feature do

  let(:user) { create(:user) }
   
  scenario 'valid inputs' do   
    sign_in user
    visit new_subscribe_path
    select 'Bulldog', from: 'subscribe[subscriptions_attributes][0][breed_id]', match: :first
    select 'Lviv', from: 'subscribe[subscriptions_attributes][0][city_id]', match: :first
    select '2', from: 'subscribe[subscriptions_attributes][0][age_from]', match: :first
    select '4', from: 'subscribe[subscriptions_attributes][0][age_to]', match: :first
    click_on 'Subscribe'
    expect(page).to have_content('Subscribe was successfully created.')
    visit subscribes_path
    expect(page).to have_content('My subscriptions')
  end


  scenario 'invalid inputs' do
    user3 = create(:user)
    sign_in user3
    visit new_subscribe_path   
    select 'Lviv', from: 'subscribe[subscriptions_attributes][0][city_id]', match: :first
    select '2', from: 'subscribe[subscriptions_attributes][0][age_from]', match: :first    
    click_on 'Subscribe'
    expect(page).to have_content('New Subscribes')
  end
end