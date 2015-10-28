require "test_helper"

class EventTest < ActiveSupport::TestCase
include Capybara::DSL

fixtures :all

  test "get repos for a user" do
    VCR.use_cassette("event#mine") do
      events = Event.mine(users(:ryan))
      event = events.first

      assert_equal 30, events.count
      assert_equal "active-record-sinatra", event[:name]
      assert_equal "https://github.com/rasensio1/active-record-sinatra", repo[:url]
    end
  end

end
