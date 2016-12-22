require 'test_helper'

class ProfilesHelperTest < ActionView::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user1 = create(:user)
    sign_in @user1
    @user2 = create(:user, user_name: "user2")
  end

  test 'current user id following' do
    @user1.follow(@user2.id)
    assert current_user_is_following(@user1.id, @user2.id)
  end
end