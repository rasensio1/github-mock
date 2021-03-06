class User < ActiveRecord::Base

  validates :name, :screen_name, presence: true

  
 def self.from_omniauth(auth_info)
    user = find_or_create_by(uid: auth_info[:uid])

    user.update_attributes(
      name:               auth_info.extra.raw_info.name,
      screen_name:        auth_info.info.nickname,
      oauth_token:        auth_info.credentials.token,
      #oauth_token_secret: auth_info.credentials.secret
    )
    user
 end
end
