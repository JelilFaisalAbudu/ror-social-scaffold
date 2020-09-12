module UsersHelper

  def timeline_posts(post)
    return if !current_user.friends.include?(post.user)
  end

  def current_user?(user)
    current_user == user
  end
end