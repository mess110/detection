# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_detection-api_session',
  :secret      => '180b5e3969cb3a8169189985b7fae1ee3916363975ccfc63252b1cb56575812efbf310fc0771f985ac5117dc5569c58d9806adb126cd13fd50b924568ee72f4f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
