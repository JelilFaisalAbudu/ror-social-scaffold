module UsersHelper
  def timeline_posts(post)
    return unless current_user.friends.include?(post.user)
	end
	
	def friends
		render 'friends'
	end

	def delete_friend(friend)
		if current_user?
			link_to 'Delete', friendship_path(user_id: current_user, friend_id: friend), method: :delete
		end
	end
	

	private

	def current_user?
		@user == current_user
	end
end
