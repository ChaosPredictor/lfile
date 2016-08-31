ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
#require 'rspec/expectations'
#require 'minitest'
#require 'rspec'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
	include ApplicationHelper
	
	def is_logged_in?
		!session[:user_id].nil?
	end
  
	# Logs in a test user.
	def log_in_as(user, options = {})
		password = options[:password] || 'password'
		remember_me = options[:remember_me] || '1'
		if integration_test?
			post login_path, session: { email:user.email, password: password, remember_me: remember_me }
		else
			session[:user_id] = user.id
		end
	end
	
	private
		
		# Returns true inside an integration test.
		def integration_test?
			defined?(post_via_redirect)
		end
	
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end