require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
		@other = users(:archer)
	end
	
	test "profile display" do
		get user_path(@user)
		assert_template 'users/show'
		assert_select 'title', full_title(@user.name)
		assert_select 'h1', text: @user.name
		assert_select 'h1>img.gravatar'
		assert_match @user.microposts.count.to_s, response.body
		assert_select 'div.pagination'
		@user.microposts.paginate(page: 1).each do |micropost|
			assert_match micropost.content, response.body
		end
	end
	
	test "home page display" do
		log_in_as(@user)
		get root_path
		assert_template 'static_pages/home'
		assert_select 'title', full_title("Home")
		assert_select 'h3', text: @user.name
		assert_select 'a>img.gravatar'
		id = @user.id
		following_ids = @user.following_ids
		allPost = Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
		assert_match allPost.count.to_s, response.body
		assert_select '.container'
		allPost.paginate(page: 1).each do |micropost|			
			assert_match micropost.content, response.body
		end
	end
end
