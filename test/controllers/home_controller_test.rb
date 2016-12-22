require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test "user sign up" do
    assert_difference('User.count', 1) do
      post :create, user: { email: 'user1@email.com', password: 'password', password_confirmation: 'password', user_name: 'user_1' }
    end
  end

  test 'user sign up redirects to home page' do
    post :create, user: { email: 'user1@email.com', password: 'password', password_confirmation: 'password', user_name: 'user_1' }

    assert_redirected_to root_url
  end

  test 'create invalid user should render new' do
    post :create, user: { email: '', password: '', password_confirmation: '', user_name: '' }

    assert_not_nil assigns(:user).errors
    assert_response :success
    assert_template :new
  end

end
