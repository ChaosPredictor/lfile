class SessionsHelperTest < ActionView::TestCase
	
	def setup
		@user1 = users(:michael)
		@user2 = users(:dmitry)
		remember(@user1)
	end
	
	test "current_user returns right user when session is nil" do
		assert_equal @user1, current_user
		assert is_logged_in?
	end
	
	test "current_user returns nil when remember digest is wrong" do
		@user1.update_attribute(:remember_digest, User.digest(User.new_token))
		assert_nil current_user
	end
	
	test "current_user returns nil when remember other user" do
		assert_not_equal @user2, current_user
	end
end