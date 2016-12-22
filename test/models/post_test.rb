require 'test_helper'

class PostTest < ActiveSupport::TestCase

  setup do
    @user = create(:user)
    @post = Post.new(caption: 'caption 1', image: File.new("#{Rails.root}/test/sunset.jpg"), user_id: @user.id)
  end

  test 'post is valid' do
    assert @post.valid?
  end

  test 'post requires image' do
    @post.image = nil

    assert !@post.valid?
    assert_equal ["can't be blank"], @post.errors[:image]
  end

  test 'post requires user' do
    @post.user = nil

    assert !@post.valid?
    assert_equal ["can't be blank"], @post.errors[:user_id]
  end

  test 'post cannot be non image file' do
    @post.image = File.new("#{Rails.root}/test/fixtures/textfile.txt")

    assert !@post.valid?
    assert_equal ["is invalid."], @post.errors[:image]
    assert_equal ["is invalid."], @post.errors[:image_content_type]
  end
end
