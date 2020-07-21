require 'rails_helper'

RSpec.describe 'Adding to favorites', type: :feature, js: true do
   
  let!(:user) { create(:user) }
  before(:each) { sign_in user }

  scenario 'from main list' do    
    dog = create(:dog, name: "Buddy")
    visit dogs_path
    expect(page).to have_content('Buddy')
    click_on 'Add to favorites', match: :first
    wait_for_ajax
    expect(page).to have_content('Remove from favorites')
    visit my_favorites_path
    expect(page).to have_content('Buddy')    
  end

  scenario 'from personal list' do    
    dog = create(:dog, name: "John", user_id: user.id)
    visit my_list_path
    expect(page).to have_content('John')
    click_on 'Add to favorites', match: :first
    wait_for_ajax
    expect(page).to have_content('Remove from favorites')
    visit my_favorites_path
    expect(page).to have_content('John')    
  end
end