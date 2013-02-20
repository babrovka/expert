Expert::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false
  config.logger = Logger.new(Rails.root.join("log", Rails.env + ".log"), 1, 1 * 1024 * 1024)
  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local          = true
  config.action_controller.perform_caching    = false
  
  config.active_support.deprecation :log

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true
  
  #config.action_mailer.smtp_settings = {
  #  :enable_starttls_auto => true,
  #  :address  => "smtp.gmail.com",
  #  :port  => 587,
  #  :domain  => "gmail.com",
  #  :user_name  => "noreply.ekka@gmail.com",
  #  :password  => "ekkaekka",
  #  :authentication  => :plain
  #}
end