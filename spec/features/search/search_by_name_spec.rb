require 'rails_helper'

RSpec.describe 'Search by name', type: :feature, js: true do

    before(:each) { visit dogs_path }

  scenario 'succsess' do  
    
    fill_in "Search", with: "Buddy"
    click_on "Search", match: :first
    wait_for_ajax
    wait_for_ajax  
    wait_for_ajax  
    expect(page).to have_content("Buddy")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Abba")
    expect(page).to have_no_content("Lord")
  end  

  scenario 'empty string' do   
   
    fill_in "Search", with: ""
    click_on "Search", match: :first
    wait_for_ajax
    wait_for_ajax  
    wait_for_ajax  
    expect(page).to have_content("Buddy")
    expect(page).to have_content("Abba")
    expect(page).to have_content("Lord")
  end  
end