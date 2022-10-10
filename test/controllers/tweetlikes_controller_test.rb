require 'test_helper'

class TweetlikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tweetlike = tweetlikes(:one)
  end

  test "should get index" do
    get tweetlikes_url
    assert_response :success
  end

  test "should get new" do
    get new_tweetlike_url
    assert_response :success
  end

  test "should create tweetlike" do
    assert_difference('Tweetlike.count') do
      post tweetlikes_url, params: { tweetlike: {  } }
    end

    assert_redirected_to tweetlike_url(Tweetlike.last)
  end

  test "should show tweetlike" do
    get tweetlike_url(@tweetlike)
    assert_response :success
  end

  test "should get edit" do
    get edit_tweetlike_url(@tweetlike)
    assert_response :success
  end

  test "should update tweetlike" do
    patch tweetlike_url(@tweetlike), params: { tweetlike: {  } }
    assert_redirected_to tweetlike_url(@tweetlike)
  end

  test "should destroy tweetlike" do
    assert_difference('Tweetlike.count', -1) do
      delete tweetlike_url(@tweetlike)
    end

    assert_redirected_to tweetlikes_url
  end
end
