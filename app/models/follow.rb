class Follow < ActiveRecord::Base
  validates_presence_of :following_id, :follower_id
  validates_uniqueness_of :following_id, scope: :follower_id

  belongs_to :follower, foreign_key: 'follower_id', class_name: 'User'
  belongs_to :following, foreign_key: 'following_id', class_name: 'User'
end
