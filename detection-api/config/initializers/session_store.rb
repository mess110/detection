# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_detection-api_session',
  :secret      => 'c551f5f70b0655a4e795ee582ebf4250401f4e1347ca5fdbf9055000bf58880f03feb7566a3c579d33734a38170a23aaf35178d4a2cf7c5198157f954343ae55'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
