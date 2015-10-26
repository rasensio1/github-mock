class User < ActiveRecord::Base
 def self.from_omniauth(auth_info)
   byebug
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid                = auth_info.uid
      new_user.name               = better_info.extra.raw_info.name
      new_user.screen_name        = better_info.extra.raw_info.login
      new_user.oauth_token        = better_info.credentials.token
      #new_user.oauth_token_secret = better_info.credentials.secret
    end
 end 

 private
  def better_info(auth_info)
    auth_info.extra.raw_info
  end
end
