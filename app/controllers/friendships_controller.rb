class FriendshipsController < ApplicationController
	before_action :setup_friends


	def create
		Friendship.request(@current_user, @friend)
		flash[:notice] = 'Friend request sent.'
		redirect_to users_path
	end

	def update
		if @current_user.requested_friends.include?(@friend)
			Friendship.accept(@current_user, @friend)
			flash[:notice] = "Friendship with #{@friend.name} accepted!"
		else
			flash[:alert] = "You have no friend request from #{@friend.name}"
		end
		redirect_to root_path
	end
	

	def destroy
		if @current_user.friends.include?(@friend)
			Friendship.breakup(@current_user, @friend)
			flash[:notice] = "Friend deleted!"
			redirect_to root_path
		else
			flash[:alert] = 'Your operation was not successful!'
		end
		redirect_to root_path
	end

	def decline
		if @current_user.requested_friends.include?(@friend)
		Friendship.breakup(@current_user, @friend)
		flash[:notice] = "Friendship declined"
		else
		flash[:notice] = "No friendship request from #{@friend.screen_name}."
		end
		redirect_to @current_user
		end

		def cancel
			if @current_user.pending_friends.include?(@friend)
			Friendship.breakup(@current_user, @friend)
			flash[:notice] = "Request canceled."
			else
			flash[:notice] = "No request for friendship with #{@friend.screen_name}"
			end
			redirect_to @current_user
			end

	private

	def setup_friends
		@current_user = User.find_by(id: current_user.id)
		@friend = User.find(params[:friend_id])
	end
end
