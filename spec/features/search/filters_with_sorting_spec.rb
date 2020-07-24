require 'rails_helper'

RSpec.describe 'Filters with sorting', type: :feature, js: true do

  before(:each) { visit dogs_path }

  scenario 'by city, age_to and date' do   
    select 'Kharkiv', from: 'city_id', match: :first
    select '4', from: 'age_to', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Fred")
    expect(page).to have_content("Lord")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Max")
    expect(page.find(".card-body", match: :first)).to have_content("Lord")
    click_on "Date", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page.find(".card-body", match: :first)).to have_content("Fred")   
  end  

  scenario 'by city, age_to and breed' do   
    select 'Kharkiv', from: 'city_id', match: :first
    select '4', from: 'age_to', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Fred")
    expect(page).to have_content("Lord")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Max")
    expect(page.find(".card-body", match: :first)).to have_content("Lord")
    click_on "Breed", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page.find(".card-body", match: :first)).to have_content("Fred")   
  end 
end