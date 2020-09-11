module FriendshipsHelper
  def ask_friendship_or(user, friend)
    friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
    return if !friendship.nil? || user != current_user

    content_tag(:button, class: 'btn') do
      link_to 'Add Friend', friendships_path(user_id: user, friend_id: friend), method: :post
    end
  end

  private

  def not_friends?(user, friend)
    Friendship.find_by_user_id_and_friend_id(user, friend).nil?
  end
end
