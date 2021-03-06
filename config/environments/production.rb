Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
	

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like
  # NGINX, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  #config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
	config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
	
  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  #config.force_ssl = true
  config.force_ssl = false	

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

#Yandex

#  config.action_mailer.default_url_options = {:host => 'lfile.website', :from => 'webmaster@lfile.website'}
#  config.action_mailer.delivery_method = :smtp
#  config.action_mailer.smtp_settings = {
#    #:tls => true,
#    :address => "smtp.yandex.ru",
#    :port => 587,
#    :domain => 'lfile.website',
#    :authentication => :plain,
#    :user_name => ENV['email_username'],
#    :password => ENV['email_password'],
#  }


#Gmail

#  config.action_mailer.default_url_options = { :host => 'lfile.website' }

#  ActionMailer::Base.delivery_method = :smtp
#  ActionMailer::Base.perform_deliveries = true
#  ActionMailer::Base.raise_delivery_errors = true
#  ActionMailer::Base.smtp_settings = {
#    :address            => 'smtp.gmail.com',
#    :port               => 587,
#    :domain             => 'gmail.com', #you can also use google.com
#    :authentication     => :plain,
#    :user_name          => "dmitrykuznichov@gmail.com",
#    :password           => "adgjmp12"
#}




# Postfix

config.action_mailer.delivery_method = :sendmail
# Defaults to:
# config.action_mailer.sendmail_settings = {
#   location: '/usr/sbin/sendmail',
#   arguments: '-i -t'
# }
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true
config.action_mailer.default_options = {from: 'no-reply@lfile.download'}
config.action_mailer.default_url_options = { :host => 'lfile.download' }
	
#	config.action_mailer.raise_delivery_errors = true
#	config.action_mailer.delivery_method = :smtp
#	host = '<your heroku app>.herokuapp.com'
#	config.action_mailer.default_url_options = { host: host }
#	ActionMailer::Base.smtp_settings = { 
#		:address => 'smtp.sendgrid.net',
#		:port => '587',
#		:authentication => :plain,
#		:user_name => ENV['SENDGRID_USERNAME'],
#		:password => ENV['SENDGRID_PASSWORD'],
#		:domain => 'heroku.com',
#		:enable_starttls_auto => true
#	}

#	ActionMailer::Base.smtp_settings = { 
#		:address => 'smtp.yandex.ru',
#		:portt => '465', #'587', #'465'
#		:tls => true,
#		:authentication => :plain,
#		:user_name => ENV['email_username'],
#		:password => ENV['email_password'],
#		:domain => 'yandex.ru',
#		:enable_starttls_auto => true
#	}
	
	#downlaod files
	#config.serve_static_files = false
	#config.serve_static_assets = true
	#config.serve_static_files = true
	config.public_file_server.enabled = true
end
