require "test_helper"

class UserViewsProfileTest < ActionDispatch::IntegrationTest
include Capybara::DSL

  test "viewing profile layout" do
    VCR.use_cassette("profile layout") do
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

  test "viewing stored data" do
    VCR.use_cassette("profile data") do
      log_in
      visit "/profile"

      assert page.has_content?("3")
      assert page.has_content?("6")
      assert page.has_content?("Organizations")
      assert page.has_content?("Starred")
      assert page.has_content?("Contribution Summary")
      assert page.has_content?("My Activity")
      assert page.has_content?("Following Activity")
    end
  end

  test "viewing queried data" do
    VCR.use_cassette("profile data") do
      log_in
      visit "/profile"

      assert page.has_content?("1,012")
      assert page.has_content?("2 days")
      assert page.has_content?("lesson_plans")
      assert page.has_content?("Create Repository")
      assert page.has_content?("roseak")
      assert page.has_content?("github-mock")
      assert page.has_content?("black-jacky")
      assert page.has_content?("fordo_site")
    end
  end

end
