require 'rails_helper'

RSpec.describe 'Deleting a subscribe', type: :feature do

  let(:user) { create(:user) }
   
  scenario 'success' do
    sign_in user
    subscribe = create(:subscribe, user_id: user.id)
    visit subscribes_path
    expect(page).to have_content('Breed')
    click_on 'Unsubscribe'
    expect(page).to have_content('Subscribe was successfully destroyed.')
    expect(page).to have_content('If you have not found the dog you need, you can subscribe by specifying the criteria of the dog you need.')
  end
end