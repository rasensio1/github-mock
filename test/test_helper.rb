ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock'
require 'vcr'

class ActiveSupport::TestCase
  fixtures :all

  VCR.configure  do |c|
    c.cassette_library_dir = 'test/cassettes'
    c.hook_into :webmock
  end

  def setup
    Capybara.app = GithubMock::Application
    stub_omniauth
  end

  def log_in
    visit login_path
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
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
  end

end
