require "application_system_test_case"

class TweetlikesTest < ApplicationSystemTestCase
  setup do
    @tweetlike = tweetlikes(:one)
  end

  test "visiting the index" do
    visit tweetlikes_url
    assert_selector "h1", text: "Tweetlikes"
  end

  test "creating a Tweetlike" do
    visit tweetlikes_url
    click_on "New Tweetlike"

    click_on "Create Tweetlike"

    assert_text "Tweetlike was successfully created"
    click_on "Back"
  end

  test "updating a Tweetlike" do
    visit tweetlikes_url
    click_on "Edit", match: :first

    click_on "Update Tweetlike"

    assert_text "Tweetlike was successfully updated"
    click_on "Back"
  end

  test "destroying a Tweetlike" do
    visit tweetlikes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tweetlike was successfully destroyed"
  end
end
