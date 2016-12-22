class Post < ActiveRecord::Base

  validates_presence_of :image, :user_id

  has_attached_file :image, styles: { :medium => '640x640>', :small => '400x400>'}
  validates_attachment_content_type :image, :content_type => /^image\/(jpg|jpeg|png|gif)$/, message: 'is invalid.'

  scope :of_followed_users, -> (following_users) { where user_id: following_users }

  belongs_to :user
  has_many :comments, dependent: :destroy

end
