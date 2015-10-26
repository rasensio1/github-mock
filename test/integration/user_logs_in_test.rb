require "test_helper"

class UserLogsInTest < ActionDispatch::IntegrationTest
include Capybara::DSL

  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Log In"
    assert_equal "/", current_path
    assert page.has_content?("Profile")
    assert page.has_link?("Log Out")
  end

end
