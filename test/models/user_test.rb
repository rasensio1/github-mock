require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "creates a valid user" do
      mock_auth = OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        provider: 'twitter',
        extra: {
          raw_info: {
            user_id: "1234",
            name: "Ryan A",
            screen_name: "rasensio1",
            followers: "3",
            following: "6",
            avatar_url: "https://github.com/images/error/ohyeah.jpg",
          }
        },
        credentials: { token: "pizza" },
        info: {nickname: "rasensio1"}
     })

     user = User.from_omniauth(mock_auth)
     assert user.valid? 
   end
end
