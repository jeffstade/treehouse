require 'test_helper'

class UserTest < ActiveSupport::TestCase

	should have_many :user_friendships
	should have_many :friends
	
	test "a user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a unique profile name" do
		user = User.new
		user.profile_name = users(:jeff).profile_name

		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new(first_name: 'Jeff', last_name: 'Stern', email:'jeff2@wer.com')
		user.password = user.password_confirmation = 'abcabc2abc'
		user.profile_name = "My profile with spaces"
		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("Must be formatted correctly.")
	end

	test "a user can have a correctly formatted profile name" do
		user = User.new(first_name: 'Jeff', last_name: 'Stern', email:'jeff@wer.com')
		user.password = user.password_confirmation = 'abcabcabc'
		user.profile_name = 'jeff_1'
		assert user.valid?
	end

	test "no error raised when trying to access a friend list" do
		assert_nothing_raised do
			users(:jeff).friends
		end
	end

	test "creating friendships on a user works" do
		users(:jeff).friends << users(:mike)
		assert users(:jeff).friends.include?(users(:mike))
	end

	test "creating friendships based on user id and friend id works" do
		UserFriendship.create user_id: users(:jeff).id, friend_id: users(:mike).id
		assert users(:jeff).friends.include?(users(:mike))
	end

  # test "the truth" do
  #   assert true
  # end
end
