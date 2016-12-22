require 'test_helper'

class UserSignInTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:user, user_name: "user1")
  end

  test 'cannot access root page without user sign in' do
    get '/'

    assert_redirected_to '/users/sign_in'
  end

  test 'cannot access browse page without user sign in' do
    get '/browse'

    assert_redirected_to '/users/sign_in'
  end

  test 'cannot access new post without user sign in' do
    get '/posts/new'

    assert_redirected_to '/users/sign_in'
  end

  test 'user sign in renders posts#index' do
    post_via_redirect '/users/sign_in', 'user[email]' => 'user1@example.com', 'user[password]' => 'password'

    assert_response :success
    assert_template 'posts/index'
    assert response.body.include? 'Fotobook'
    assert response.body.include? 'Home'
    assert response.body.include? @user.user_name
    assert response.body.include? 'New Post'
    assert response.body.include? 'Sign out'
  end
end
