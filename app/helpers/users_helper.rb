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
	def requested_friends
		if current_user?
			render 'requested_friends'
		end
	end

	def pending_friends
		if current_user?
			render 'pending_friends'
		end
	end

	private

	def current_user?
		@user == current_user
	end
end
