require "test_helper"

class UserLogsInTest < ActionDispatch::IntegrationTest
include Capybara::DSL

  test "logging in" do
    VCR.use_cassette("logging in") do
      visit "/"
      click_link "Log Out" if page.has_content?("Log Out")
      assert_equal 200, page.status_code
      click_link "Log In"
      assert_equal profile_path, current_path
      assert page.has_content?("Profile")
      assert page.has_link?("Log Out")
    end
  end

end
