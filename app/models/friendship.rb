class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'



  # Check to find out if there exist between these two 
  def self.exist?(user, friend)
    !find_by_user_id_and_friend_id(user, friend).nil?
  end

  #  For sending friend rquests
  def self.request(user, friend)
    unless user == friend || Friendship.exist?(user, friend)
      transaction do
        create(user: user, friend: friend, status: 'pending')
        create(user: friend, friend: user, status: 'requested')
      end
    end
  end

  # Accept the friend request
  def self.accept(user, friend)
    transaction do
      accepted_at = Time.now
      accept_one_side(user, friend, accepted_at)
      accept_one_side(friend, user, accepted_at)
    end
  end

  # For deleting or cancelling a pending request
  def self.breakup(user, friend)
    transaction do
      friendship1 = find_by_user_id_and_friend_id(user, friend)
      friendship2 = find_by_user_id_and_friend_id(friend, user)
      destroy(friendship1.id)
      destroy(friendship2.id)
    end
  end

  private

  #  For updating the status and updated time of acceptace
  def self.accept_one_side(user, friend, accepted_at)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'accepted'
    request.updated_at = accepted_at
    request.save!
  end
end
