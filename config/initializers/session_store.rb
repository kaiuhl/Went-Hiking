# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hiking_stats_session',
  :secret      => 'ffdd498a9ed6a235c425932d0fbc02da14fdcaa85e60c6def566bba21dd7e58273c4c2c13a7d5006841deb97d659e822fc7c1f29ee6c1bb8c41a5ba777ffbfff'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
