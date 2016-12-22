require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user_with_posts)
    sign_in @user
    @post = @user.posts.first
  end

  test 'index renders load all' do
    get :index, :post_id => @post.id, :format => "js"

    assert_response :success
    assert_template :load_all
  end

  test 'create saves comment to the database' do
    assert_difference 'Comment.count', 1 do
      post :create, :post_id => @post.id, :format => "js", :comment => { content: 'comment 1' }
    end
  end

  test 'create renders create' do
    post :create, :post_id => @post.id, :format => "js", :comment => { content: 'comment 1' }

    assert_response :success
    assert_template :create
  end

  test 'destroy deletes the comment from db' do
    @comment = @post.comments.create(content: "new comment", user_id: @user.id)

    assert_difference 'Comment.count', -1 do
      delete :destroy, :id => @comment.id, :post_id => @post.id, :format => "js"
    end
  end

end
