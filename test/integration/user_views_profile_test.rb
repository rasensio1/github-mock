require "test_helper"

class UserViewsProfileTest < ActionDispatch::IntegrationTest
include Capybara::DSL

  test "viewing profile" do
    log_in
    click_link "Profile"

    assert_equal profile_path, current_path
    assert page.has_content?("Ryan A")
    assert page.has_content?("rasensio1")
    assert page.has_content?("Contribution Summary")
    assert page.has_content?("Organizations")
    assert page.has_content?("Starred Repos")
  end

end
