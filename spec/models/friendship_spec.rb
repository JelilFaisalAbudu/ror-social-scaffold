require 'rails_helper'
RSpec.describe Friendship, type: :model do
  before do
    @user_one = User.create(
      name: 'Jelil',
      email: 'jelil@example.com',
      password: '1234567890',
      password_confirmation: '1234567890'
    )

    @user_two = User.create(
      name: 'Abudu',
      email: 'abudu@example.com',
      password: '1234567890',
      password_confirmation: '1234567890'
    )

    @user_three = User.create(
      name: 'Jane',
      email: 'jane@example.com',
      password: '1234567890',
      password_confirmation: '1234567890'
    )
  end

  context 'ActiveRecord associations' do
    it 'belongs to user' do
      user = Friendship.reflect_on_association(:user)
      expect(user.macro).to eq(:belongs_to)
    end

    it 'belongs to friend' do
      user = Friendship.reflect_on_association(:friend)
      expect(user.macro).to eq(:belongs_to)
    end
  end

  context 'Attributes Validation' do
    friendship = Friendship.new(user_id: @user_one, friend_id: nil, status: 'pending')

    it 'should invalidate the user_id of value nil' do
      expect(friendship).to_not be_valid
    end

    it 'should validate the presence of the values for user_id and friend_id' do
      friendship = Friendship.create(user_id: @user_three.id, friend_id: @user_one.id, status: 'accepted')
      expect(friendship).to be_valid
    end
  end
end
