# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sample_app_session',
  :secret      => '6c1f8dbdaae8c208f068a7e88c517aac1927c95a57b60082019ff2a364b3c9f59a30477faaf3bda5864de86d375448102d4f7271e126c24f09f409a193c744e7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
