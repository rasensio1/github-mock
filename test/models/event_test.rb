require "test_helper"

class EventTest < ActiveSupport::TestCase
  include Capybara::DSL
  fixtures :all

  test "gets events for a user" do
    VCR.use_cassette("event#mine") do
      events = Event.mine(users(:ryan))
      event = events.first

      assert_equal 10, events.count
      assert_equal "rasensio1/github-mock", event.repo_name
      assert_equal "https://github.com/rasensio1/github-mock", event.repo_url
      assert_equal "Push", event.type
    end
  end

  test "gets received events for a user" do
    VCR.use_cassette("event#received") do
      events = Event.mine(users(:ryan))
      event = events.first

      assert_equal 10, events.count
      assert_equal "rasensio1/github-mock", event.repo_name
      assert_equal "https://github.com/rasensio1/github-mock", event.repo_url
      assert_equal "Push", event.type
    end
  end
end
