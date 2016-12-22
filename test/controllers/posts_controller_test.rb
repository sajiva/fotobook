require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user_with_posts)
    sign_in @user
  end

  test 'index assigns posts and renders index' do
    get :index

    assert_equal 5, assigns(:posts).count
    assert_response :success
    assert_template :index
  end

  test 'new assigns post and renders new' do
    get :new

    assert_not_nil assigns(:post)
    assert_response :success
    assert_template :new
  end

  test 'create saves post to the database' do
    assert_difference 'Post.count', 1 do
      post :create, :post => { caption: 'caption 1', image: fixture_file_upload('tiger.jpg', 'image/jpeg') }
    end
  end

  test 'create redirects to show' do
    post :create, :post => {caption: 'caption 1', image: fixture_file_upload('tiger.jpg', 'image/jpeg') }

    created_post = Post.last

    assert_redirected_to "/posts/#{created_post.id}"
  end

  test 'create invalid post should render new' do
    post :create, :post => {image: '', caption: ''}

    assert_not_nil assigns(:post).errors
    assert_equal ["can't be blank"], assigns(:post).errors[:image]
    assert_response :success
    assert_template :new
  end

  test 'show renders show' do
    get :show, :id => Post.first.id

    assert_not_nil assigns(:post)
    assert_response :success
    assert_template :show
  end

  test 'edit renders edit' do
    get :edit, :id => Post.first.id

    assert_not_nil assigns(:post)
    assert_response :success
    assert_template :edit
  end

  test 'update modifies the post and redirects to show' do
    put :update, :id => Post.first.id, :post => {caption: 'This is updated caption'}

    assert_equal 'This is updated caption', assigns(:post).caption
    assert_redirected_to "/posts/#{assigns(:post).id}"
  end

  test 'destroy deletes the post from db' do

    assert_difference 'Post.count', -1 do
      delete :destroy, :id => Post.first.id
    end
  end

  test 'delete redirects to index' do
    delete :destroy, :id => Post.first.id

    assert_redirected_to "/posts"
  end

  test 'user cannot edit other user post' do
    @user2 = create(:user_with_posts, user_name: "user2")
    get :edit, :id => Post.last.id

    assert_redirected_to posts_path
  end

  test 'browse assigns posts and renders browse' do
    get :browse

    assert_not_nil assigns(:posts)
    assert_response :success
    assert_template :browse
  end

end
