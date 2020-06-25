require "application_system_test_case"

class SubscribesTest < ApplicationSystemTestCase
  setup do
    @subscribe = subscribes(:one)
  end

  test "visiting the index" do
    visit subscribes_url
    assert_selector "h1", text: "Subscribes"
  end

  test "creating a Subscribe" do
    visit subscribes_url
    click_on "New Subscribe"

    fill_in "User", with: @subscribe.user_id
    click_on "Create Subscribe"

    assert_text "Subscribe was successfully created"
    click_on "Back"
  end

  test "updating a Subscribe" do
    visit subscribes_url
    click_on "Edit", match: :first

    fill_in "User", with: @subscribe.user_id
    click_on "Update Subscribe"

    assert_text "Subscribe was successfully updated"
    click_on "Back"
  end

  test "destroying a Subscribe" do
    visit subscribes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subscribe was successfully destroyed"
  end
end
