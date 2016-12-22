class User < ActiveRecord::Base

  validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :image, styles: { medium: '640x640#', small: '100x100#', thumb: '50x50#' }
  validates_attachment_content_type :image, :content_type => /^image\/(jpg|jpeg|png|gif)$/, message: 'is invalid.'

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end
end
