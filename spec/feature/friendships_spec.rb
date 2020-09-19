require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.feature 'Friendship management', type: :feature do
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
  scenario 'with first visit to the site' do
    visit root_path
    expect(page).to have_content('Sign in')
  end

  scenario 'with a user successfully signed in' do
    sign_in_with(@user_one.email, @user_one.password)
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'with a user sending friend request' do
    sign_in_with(@user_one.email, @user_one.password)
    click_link 'All users'
    click_button('Add Friend', match: :first)
    click_link @user_one.name
    expect(@user_one.pending_friends.count).to eq(0)
  end

  def sign_up_with(name, email, password, password_confirmation)
    visit 'users/sign_up'
    fill_in 'name', with: name
    fill_in 'email', with: email
    fill_in 'password', with: password
    fill_in 'password_confirmation', with: password_confirmation
    click_button 'Sign up'
  end

  def sign_in_with(email, password)
    visit 'users/sign_in'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Log in'
  end
end

# rubocop:enable Metrics/BlockLength
