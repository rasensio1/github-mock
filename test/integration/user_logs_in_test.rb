require "test_helper"

class UserLogsInTest < ActionDispatch::IntegrationTest
include Capybara::DSL

  def setup
    Capybara.app = GithubMock::Application
    stub_omniauth
  end

  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Log In"
    assert_equal "/", current_path
    assert page.has_content?("Profile")
    assert page.has_link?("Log Out")
  end


  def stub_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Horace",
          screen_name: "worace",
        }
      },
      credentials: { token: "pizza" }
    })
  end
end
