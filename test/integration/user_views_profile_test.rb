require "test_helper"

class UserViewsProfileTest < ActionDispatch::IntegrationTest
include Capybara::DSL

  test "viewing profile" do
    log_in
    click_link "Profile"

    assert_equal profile_path, current_path
  end

end
