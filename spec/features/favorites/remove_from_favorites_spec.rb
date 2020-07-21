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
    expect(page).to have_content('Remove from favorites')
    click_on 'Remove from favorites', match: :first
    visit my_favorites_path
    expect(page).to have_no_content('James')    
  end

  scenario 'from personal list' do    
    dog = create(:dog, name: "Mikie", user_id: user.id)
    visit my_list_path
    expect(page).to have_content('Mikie')
    click_on 'Add to favorites', match: :first
    wait_for_ajax
    expect(page).to have_content('Remove from favorites')
    click_on 'Remove from favorites', match: :first
    visit my_favorites_path
    expect(page).to have_no_content('Mikie')    
  end

  scenario 'from favorites list' do    
    dog = create(:dog, name: "Jordan", user_id: user.id)
    visit my_list_path
    click_on 'Add to favorites', match: :first
    wait_for_ajax
    visit my_favorites_path
    click_on 'Remove', match: :first
    expect(page).to have_no_content('Jordan')    
  end
end