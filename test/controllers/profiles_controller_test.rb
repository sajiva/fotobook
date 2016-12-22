require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user)
    sign_in @user
  end

  test 'show renders show' do
    get :show, :user_name => @user.user_name

    assert_not_nil assigns(:posts)
    assert_response :success
    assert_template :show
  end

  test 'edit renders edit' do
    get :edit, :user_name => @user.user_name

    assert_response :success
    assert_template :edit
  end

  test 'update redirects to the user profile' do
    @image = fixture_file_upload('tiger.jpg', 'image/jpeg')
    patch :update, :user_name => @user.user_name, :user => {image: @image}

    assert_redirected_to "/#{@user.user_name}"
  end

  test 'invalid update renders edit' do
    @image = fixture_file_upload('textfile.txt')
    patch :update, :user_name => @user.user_name, :user => {image: @image}

    assert_template :edit
  end

  test 'user cannot edit other user profile' do
    @user2 = create(:user, user_name: "user2")
    get :edit, :user_name => @user2.user_name

    assert_redirected_to "/#{@user2.user_name}"
  end
end
