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
	
	def session_check_for(current_user)
    if current_user
      render 'user_info'

    else
      link_to 'Sign in', user_session_path
    end
  end

  private

  def current_user?
    @user == current_user
  end
end
