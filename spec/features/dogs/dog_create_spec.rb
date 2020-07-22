require 'rails_helper'

RSpec.describe 'Creating a dog', type: :feature do

    feature "Regular User" do

        let!(:user) { create(:user) }
        before(:each) do
          sign_in user
          visit my_list_path
          click_on 'Add new Dog'  
        end

        scenario 'valid inputs' do
            fill_in "Name", with: 'Abuba'
            select '2', from: 'dog_breed_id', match: :first
            select '2', from: 'dog_city_id', match: :first
            select '3', from: 'dog_age_id', match: :first
            click_on 'Submit'
            visit dogs_path
            expect(page).to have_content('Abuba')
        end

        scenario 'invalid inputs' do
            fill_in "Name", with: 'AASD'
            select '2', from: 'dog_breed_id', match: :first
            select '2', from: 'dog_city_id', match: :first
            click_on 'Submit'
            expect(page).to have_content("Age must exist")
        end
    end

    feature "Admin" do

        let!(:user) { create(:user, roles: "site_admin") }
        before(:each) do
          sign_in user
          visit dogs_path 
          click_on 'Add new Dog'  
        end

        scenario 'valid inputs' do
            fill_in "Name", with: 'QWERTY'
            select '2', from: 'dog_breed_id', match: :first
            select '2', from: 'dog_city_id', match: :first
            select '3', from: 'dog_age_id', match: :first
            click_on 'Submit'
            visit dogs_path
            expect(page).to have_content('QWERTY')
        end

        scenario 'invalid inputs' do
            fill_in "Name", with: 'QWERTY'
            select '2', from: 'dog_breed_id', match: :first
            select '2', from: 'dog_city_id', match: :first
            click_on 'Submit'
            expect(page).to have_content("Age must exist")
        end
    end
end