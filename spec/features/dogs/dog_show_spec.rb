require 'rails_helper'

RSpec.describe 'Show a dog', type: :feature do

  scenario 'from main list' do
    dog = create(:dog, name: "Dadario")
    visit dogs_path
    expect(page).to have_content('Dadario')
    click_on 'Show', match: :first
    expect(page).to have_content('Dadario')
    expect(page).to have_content('Author')
    expect(page).to have_content('Breed')
    expect(page).to have_content('City')   
  end

  scenario 'from personal list' do
    user = create(:user)
    sign_in user
    dog = create(:dog, name: "Maximum", user_id: user.id)
    visit dogs_path
    expect(page).to have_content('Maximum')
    visit my_list_path
    expect(page).to have_content('Maximum')
    click_on 'Show', match: :first
    expect(page).to have_content('Maximum')
    expect(page).to have_content('Author')
    expect(page).to have_content('Breed')
    expect(page).to have_content('City')   
  end
end