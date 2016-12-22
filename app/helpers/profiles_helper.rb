module ProfilesHelper
  def profile_image_select(user)
    return image_tag user.image.url(:small) if user.image.exists?
    image_tag 'default_image.png'
  end

  def current_user_is_following(current_user_id, followed_user_id)
    relationship = Follow.find_by(follower_id: current_user_id, following_id: followed_user_id)
    return true if relationship
  end
end
