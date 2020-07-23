require 'rails_helper'

RSpec.describe 'Filter', type: :feature, js: true do

    before(:each) do 
        visit dogs_path
    end

  scenario 'by all parameters' do   
    select 'Bulldog', from: 'breed_id', match: :first
    select 'Kyiv', from: 'city_id', match: :first
    select '1', from: 'age_from', match: :first
    select '3', from: 'age_to', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Abba")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Lord")
  end  

  scenario 'by breed' do   
    select 'Bulldog', from: 'breed_id', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Abba")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Lord")
  end   

  scenario 'by city' do   
    select 'Lviv', from: 'city_id', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Rex")
    expect(page).to have_content("Buddy")
    expect(page).to have_no_content("Abba")
    expect(page).to have_no_content("Max")
    expect(page).to have_no_content("Lord")
  end  

  scenario 'by age_from' do   
    select '3', from: 'age_from', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Fred")
    expect(page).to have_content("Buddy")
    expect(page).to have_content("Charlie")
    expect(page).to have_no_content("Lord")
    expect(page).to have_no_content("Abba")
    expect(page).to have_no_content("Max")
  end

  scenario 'by age_to' do   
    select '2', from: 'age_to', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Max")
    expect(page).to have_content("Rex")
    expect(page).to have_content("Lord")
    expect(page).to have_no_content("Charlie")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Fred")
  end  

  scenario 'by breed and city' do   
    select 'Labrador', from: 'breed_id', match: :first
    select 'Lviv', from: 'city_id', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Rex")
    expect(page).to have_no_content("Fred")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Lord")
  end  

  scenario 'by breed and age_from' do   
    select 'Labrador', from: 'breed_id', match: :first
    select '1', from: 'age_from', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Rex")
    expect(page).to have_content("Fred")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Lord")
    expect(page).to have_no_content("Abba")
  end  

  scenario 'by breed and age_to' do   
    select 'Beagle', from: 'breed_id', match: :first
    select '5', from: 'age_to', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Buddy")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Abba")
    expect(page).to have_no_content("Lord")
  end   

   scenario 'by city and age_from' do   
    select 'Kharkiv', from: 'city_id', match: :first
    select '3', from: 'age_from', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Fred")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Lord")
  end 

   scenario 'by city and age_to' do   
    select 'Ternopil', from: 'city_id', match: :first
    select '2', from: 'age_to', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Max")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Lord")
  end 

  scenario 'by age_from and age_to' do   
    select '2', from: 'age_from', match: :first
    select '3', from: 'age_to', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Max")
    expect(page).to have_content("Fred")
    expect(page).to have_content("Buddy")
    expect(page).to have_no_content("Lord")
    expect(page).to have_no_content("Charlie")
    expect(page).to have_no_content("Abba")
  end  

  scenario 'by breed, city and age_from' do   
    select 'Bulldog', from: 'breed_id', match: :first
    select 'Kyiv', from: 'city_id', match: :first
    select '1', from: 'age_from', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Abba")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Lord")
  end  

  scenario 'by breed, city and age_to' do   
    select 'Poodle', from: 'breed_id', match: :first
    select 'Dnipro', from: 'city_id', match: :first
    select '10', from: 'age_to', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Charlie")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Lord")
  end  

  scenario 'by breed and ages' do   
    select 'Labrador', from: 'breed_id', match: :first
    select '3', from: 'age_from', match: :first
    select '5', from: 'age_to', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Fred")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Buddy")
    expect(page).to have_no_content("Lord")
  end  

  scenario 'by city and ages' do   
    select 'Lviv', from: 'city_id', match: :first
    select '2', from: 'age_from', match: :first
    select '4', from: 'age_to', match: :first
    within(".p-4.mb-3.bg-light.rounded") do
      click_on("Search")
    end
    wait_for_ajax
    wait_for_ajax   
    expect(page).to have_content("Buddy")
    expect(page).to have_no_content("Rex")
    expect(page).to have_no_content("Abba")
    expect(page).to have_no_content("Lord")
  end  



end