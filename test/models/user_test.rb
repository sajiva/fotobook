require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @user2 = create(:user, user_name: "user2")
  end

  test 'user is valid' do
    assert @user.valid?
  end

  test 'user requires email' do
    @user.email = ''

    assert !@user.valid?
    assert_equal ["can't be blank"], @user.errors[:email]
  end

  test 'user requires unique email' do
    @user.email = @user2.email

    assert !@user.valid?
    assert_equal ["has already been taken"], @user.errors[:email]
  end

  test 'user requires username' do
    @user.user_name = ''

    assert !@user.valid?
    assert_equal ["can't be blank", "is too short (minimum is 4 characters)"], @user.errors[:user_name]
  end

  test 'user requires unique user name' do
    @user.user_name = @user2.user_name

    assert !@user.valid?
    assert_equal ["has already been taken"], @user.errors[:user_name]
  end

  test 'username should be at least 4 characters' do
    @user.user_name = 'abc'

    assert !@user.valid?
    assert_equal ["is too short (minimum is 4 characters)"], @user.errors[:user_name]
  end

  test 'username can be at most 16 characters' do
    @user.user_name = 'thisisaverylongusername'

    assert !@user.valid?
    assert_equal ["is too long (maximum is 16 characters)"], @user.errors[:user_name]
  end

  test 'user can have an image' do
    @user.image = File.new("#{Rails.root}/test/sunset.jpg")

    assert @user.valid?
  end

  test 'error given for invalid image' do
    @user.image = File.new("#{Rails.root}/test/fixtures/textfile.txt")

    assert !@user.valid?
    assert_equal ["is invalid."], @user.errors[:image]
    assert_equal ["is invalid."], @user.errors[:image_content_type]
  end

  test 'user can follow other user' do
    assert_difference '@user.following.count', 1 do
      @user.follow(@user2.id)
    end
  end

  test 'user can unfollow other user' do
    @user.follow(@user2.id)

    assert_difference '@user.following.count', -1 do
      @user.unfollow(@user2.id)
    end
  end

end
