require 'rails_helper'

RSpec.describe 'Paginations', type: :feature, js: true do

  scenario 'go to the second page and return to the first page' do   
    visit dogs_path
    click_on "2", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("First")
    expect(page).to have_content("Prev")  
    expect(page).to have_content(Dog.first.name)
    expect(page).to have_no_content(Dog.last.name)
    click_on "First", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Next")
    expect(page).to have_content("Last")
    expect(page).to have_content(Dog.last.name)
    expect(page).to have_no_content(Dog.first.name)
  end  

  
end