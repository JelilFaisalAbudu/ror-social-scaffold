module UsersHelper
  def timeline_posts(post)
    return unless current_user.friends.include?(post.user)
  end

  def friends
    render 'friends'
  end

  def delete_friend(friend)
    link_to 'Delete', friendship_path(user_id: current_user, friend_id: friend), method: :delete if current_user?
  end

  def requested_friends
    render 'requested_friends' if current_user?
  end

  def pending_friends
    render 'pending_friends' if current_user?
  end

  private

  def current_user?
    @user == current_user
  end
end
