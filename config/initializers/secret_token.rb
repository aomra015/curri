# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Curri::Application.config.secret_key_base = if Rails.env.development? or Rails.env.test?
  '32301ede3cd683cba0a497abe16646c4875490840c241ecb101f91255437011c617174ce9bd1bd89666917a586da63607ed9ed4c0f2d58975294d407ab81a0f9'
else
  ENV['SECRET_TOKEN']
end
