# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_eubanks_family_website_session',
  :secret      => 'd0bbfd80ceaa085caf601f22dc311d5fcafe0113364a939cc32d82cc922691efc2b665e357d1db5f9183de285c80b648cae65b831dc2fca1c29d577b37410ca4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
