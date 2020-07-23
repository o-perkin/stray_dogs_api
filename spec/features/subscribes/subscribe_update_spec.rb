require 'rails_helper'

RSpec.describe 'Updating a subscribe', type: :feature do

  let!(:user) { create(:user) }
  let!(:subscribe) { create(:subscribe, user_id: user.id) }

  before(:each) do 
    sign_in user
    visit edit_subscribe_path(id: subscribe.id)
  end
   
  scenario 'valid inputs' do    
    select 'Labrador', from: 'subscribe[subscriptions_attributes][0][breed_id]', match: :first
    select 'Kyiv', from: 'subscribe[subscriptions_attributes][0][city_id]', match: :first
    select '2', from: 'subscribe[subscriptions_attributes][0][age_from]', match: :first
    select '4', from: 'subscribe[subscriptions_attributes][0][age_to]', match: :first
    click_on 'Subscribe'
    expect(page).to have_content('Subscribe was successfully updated.')
  end

  scenario 'invalid inputs' do
    select '', from: 'subscribe[subscriptions_attributes][0][breed_id]', match: :first
    select 'Lviv', from: 'subscribe[subscriptions_attributes][0][city_id]', match: :first
    select '2', from: 'subscribe[subscriptions_attributes][0][age_from]', match: :first
    select '', from: 'subscribe[subscriptions_attributes][0][age_to]', match: :first
    click_on 'Subscribe'
    expect(page).to have_content('Editing Subscriptions')
  end
end