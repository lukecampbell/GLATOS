Glatos::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w( home.js home.css )
  config.assets.precompile += %w( admin.js admin.css )
  config.assets.precompile += %w( explore.js explore.css )
  config.assets.precompile += %w( search.js search.css )
  config.assets.precompile += %w( submission.js submission.css )
  config.assets.precompile += %w( ie7.css ie6.css )
  config.assets.precompile += %w( printing.css )

  # The following original SMTP began to bomb in the production env.  So use SMTP below.
  # config.action_mailer.delivery_method = :sendmail
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.raise_delivery_errors = false
  # config.action_mailer.default :charset => "utf-8"
  # config.action_mailer.default :from => "glatos@glos.us"
  # config.action_mailer.sendmail_settings = { :arguments => '-i -t -f glatos@glos.us' }

  config.action_mailer.default_url_options = { :host => 'data.glos.us/glatos' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  # https://github.com/rails/rails/pull/6950
  ActionMailer::Base.default(from: "glatos@glos.us")
  config.action_mailer.smtp_settings = {
    :address        => 'magus.merit.edu',
    :port           => 587,
    :domain         => 'glos.us',
    :authentication => :login,
    :user_name      => 'glatos@glos.us',
    :password       => 'glatos',
    :enable_starttls_auto => true
  }

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # We run in the "glatos" subdirectory
  config.action_controller.relative_url_root = "/glatos"

  Paperclip.options[:command_path] = "/usr/bin/"

end
