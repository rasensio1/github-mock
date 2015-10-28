require "test_helper"

class RepoTest < ActiveSupport::TestCase
include Capybara::DSL

fixtures :all

  test "viewing profile layout" do
    VCR.use_cassette("repo#mine") do
      repos = Repo.mine(users(:ryan))
      repo = repos.first

      assert_equal 30, repos.count
      assert_equal "active-record-sinatra", repo[:name]
      assert_equal "https://github.com/rasensio1/active-record-sinatra", repo[:url]
    end
  end
end
