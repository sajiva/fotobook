require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @user = create(:user_with_posts)
    @post = @user.posts.first
    @comment = Comment.new(content: 'comments', post_id: @post.id, user_id: @user.id)
  end

  test 'comment is valid' do
    assert @comment.valid?
  end

  test 'comment requires post' do
    @comment.post = nil

    assert !@comment.valid?
    assert_equal ["can't be blank"], @comment.errors[:post_id]
  end

  test 'comment requires user' do
    @comment.user = nil

    assert !@comment.valid?
    assert_equal ["can't be blank"], @comment.errors[:user_id]
  end
end
