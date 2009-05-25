# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_expert_session',
  :secret      => '19ceeeade7a78ea4f091935a934d85f543b558dd0fc57027aa81dd00bc22dc82abea2219d477c81abb4ae1e8dabed1ac8b462991f358822d4655d2b1e8e85282'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
