Devise.setup do |config|

  config.mailer_sender = "mailer@tilldawn.fm"
  config.apply_schema = false
  require 'devise/orm/mongoid'
  require "omniauth-facebook"
  
  if Rails.env.development?
    # dev configuration
    config.omniauth :facebook, "300295126713931", "ee0bc07c6c82d8bf2774dc170a0ded73"
  else
    # dep configuration
    config.omniauth :facebook, "367242596644520", "9854a82bb0f535e1af8383c950016cf8"
  end


  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.sign_out_via = :delete
end
