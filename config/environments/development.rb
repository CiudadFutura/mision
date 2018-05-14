Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
  config.active_record.raise_in_transactional_callbacks = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = true

  #Token for json in product view
  config.secret_mai_token = ENV["TOKEN_MAI_GET"].present?


  config.action_mailer.delivery_method = :smtp
	config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }

	config.action_controller.asset_host = "http://0.0.0.0:3000"
	config.action_mailer.asset_host  = "http://0.0.0.0:3000"

	config.action_mailer.default_url_options = { :host => '0.0.0.0:3000' }
=begin
  config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: "www.misionantiinlfacion.com.ar",
      authentication: "plain",
      enable_starttls_auto: true,
      user_name: ENV["GMAIL_USERNAME"],
      password: ENV["GMAIL_PASSWORD"]
  }

	config.action_mailer.smtp_settings = {
			:address                          => 'smtp.zoho.com',
			:port                                 => 465,
			:user_name                     => ENV["ZOHO_MAIL_USERNAME"],
			:domain                           => ENV["ZOHO_MAIL_DOMAIN"],
			:password                       => ENV["ZOHO_MAIL_PASSWORD"],
			:authentication                => :plain,
			:ssl                                  => true,
			:tls                                  => true,
			:enable_starttls_auto     => true
	}
=end
end
