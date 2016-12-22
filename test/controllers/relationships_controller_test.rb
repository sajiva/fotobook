require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user1 = create(:user, user_name: "user1")
    sign_in @user1
    @user2 = create(:user, user_name: "user2")
  end

  test "should get follow_user" do
    get :follow_user, :user_name => @user2.user_name, :format => "js"

    assert_response :success
    assert_equal @user2.followers.first, @user1
    assert_template :follow_user
  end

  test "should get unfolllow_user" do
    @user1.follow(@user2.id)
    get :unfollow_user, :user_name => @user2.user_name, :format => "js"

    assert_response :success
    assert_equal 0, @user1.following.count
    assert_template :unfollow_user
  end

end
