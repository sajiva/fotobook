require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  setup do
    @user1 = create(:user)
    @user2 = create(:user, user_name: "user2")
    @follow = Follow.new(follower_id: @user1.id, following_id: @user2.id)
  end

  test 'follow is valid' do
    assert @follow.valid?
  end

  test 'follow requires follower' do
    @follow.follower = nil

    assert !@follow.valid?
    assert_equal ["can't be blank"], @follow.errors[:follower_id]
  end

  test 'follow requires following' do
    @follow.following = nil

    assert !@follow.valid?
    assert_equal ["can't be blank"], @follow.errors[:following_id]
  end
end
