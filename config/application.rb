require File.expand_path('../boot', __FILE__)

require 'rails/all'

#Bundler.require(:default, Rails.env) if defined?(Bundler)

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Expert
  class Application < Rails::Application
    config.encoding = 'utf-8'

    # Add additional load paths for your own custom dirs
    config.autoload_paths += %W(#{config.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Skip frameworks you're not going to use. To use Rails without a database,
    # you must remove the Active Record framework.
    # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    config.time_zone = 'Moscow'

    config.assets.enabled = true
    config.assets.precompile += %w(html5.js ie.css)

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
    address:        "smtp.gmail.com",
    port:           587, 
    domain:         "gmail.com",
    authentication: "plain",
    user_name:      "babrovka@gmail.com",
    password:       "QwertQ1234!",
    enable_starttls_auto: true
    }

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    config.i18n.default_locale = :ru
  end
end
