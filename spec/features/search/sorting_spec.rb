require 'rails_helper'

RSpec.describe 'Sorting', type: :feature, js: true do

  before(:each) { visit dogs_path }

  scenario 'by date' do   
    click_on "Date", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page.find(".card-body", match: :first)).to have_content(Dog.first.name)    
    click_on "Date", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page.find(".card-body", match: :first)).to have_content(Dog.last.name)
    expect(page).to have_css(".nav.nav-pills.flex-column.flex-sm-row.dropup")
  end  

  scenario 'by breed' do   
    click_on "Breed", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page.find(".card-body", match: :first)).to have_content(Breed.first.name)
    click_on "Breed", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page.find(".card-body", match: :first)).to have_content(Breed.last.name)
    expect(page).to have_css(".nav.nav-pills.flex-column.flex-sm-row.dropup")
  end  

  scenario 'by age' do   
    click_on "Age", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page.find(".card", match: :first)).to have_content(Age.first.years)
    click_on "Age", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page.find(".card", match: :first)).to have_content(Age.last.years)
    expect(page).to have_css(".nav.nav-pills.flex-column.flex-sm-row.dropup")
  end  

  scenario 'by city' do   
    click_on "City", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page.find(".card", match: :first)).to have_content(City.first.name)
    click_on "City", match: :first
    wait_for_ajax
    wait_for_ajax   
    expect(page.find(".card", match: :first)).to have_content(City.last.name)
    expect(page).to have_css(".nav.nav-pills.flex-column.flex-sm-row.dropup")
  end  
end