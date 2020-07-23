require 'rails_helper'

RSpec.describe 'Removing from favorites', type: :feature, js: true do

  let!(:user) { create(:user) }
  before(:each) { sign_in user }
   
  scenario 'from main list' do    
    dog = create(:dog, name: "James")
    visit dogs_path
    expect(page).to have_content('James')
    click_on 'Add to favorites', match: :first
    wait_for_ajax
    click_on 'Remove from favorites', match: :first
    wait_for_ajax
    visit my_favorites_path
    expect(page).to have_no_content('James')    
  end

  scenario 'from personal list' do    
    dog = create(:dog, name: "Mikie", user_id: user.id)
    visit my_list_path
    expect(page).to have_content('Mikie')
    click_on 'Add to favorites', match: :first
    wait_for_ajax
    click_on 'Remove from favorites', match: :first
    wait_for_ajax
    visit my_favorites_path
    expect(page).to have_no_content('Mikie')    
  end

  scenario 'from show page' do    
    dog = create(:dog, name: "Qwerqwer", user_id: user.id)
    visit dog_path(id: dog.id)
    expect(page).to have_content('Qwerqwer')
    click_on 'Add to favorites'
    wait_for_ajax
    click_on 'Remove from favorites'
    wait_for_ajax
    visit my_favorites_path
    expect(page).to have_no_content('Qwerqwer')    
  end

  scenario 'from favorites list' do    
    dog = create(:dog, name: "Jordan", user_id: user.id)
    visit my_list_path
    click_on 'Add to favorites', match: :first
    wait_for_ajax
    visit my_favorites_path
    click_on 'Remove', match: :first
    wait_for_ajax
    expect(page).to have_no_content('Jordan')    
  end
end