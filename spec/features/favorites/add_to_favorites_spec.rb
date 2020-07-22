require 'rails_helper'

RSpec.describe 'Adding to favorites', type: :feature, js: true do
   
  let!(:user) { create(:user) }
  before(:each) do 
    sign_in user
  end

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
    dog = create(:dog, name: "Zero", user_id: user.id)   
    visit my_list_path
    expect(page).to have_content('Zero')
    click_on 'Add to favorites', match: :first
    wait_for_ajax
    expect(page).to have_content('Remove from favorites')
    visit my_favorites_path
    expect(page).to have_content('Zero')    
  end

  scenario 'show page' do   
    dog = create(:dog, name: "Chuka") 
    visit dog_path(id: dog.id)
    expect(page).to have_content('Chuka')
    click_on 'Add to favorites', match: :first
    wait_for_ajax
    expect(page).to have_content('Remove from favorites')
    visit my_favorites_path
    expect(page).to have_content('Chuka')    
  end
end