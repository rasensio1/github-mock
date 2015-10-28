require "test_helper"

class RepoTest < ActiveSupport::TestCase
  include Capybara::DSL
  fixtures :all

  test "get repos for a user" do
    VCR.use_cassette("repo#mine") do
      repos = Repo.mine(users(:ryan))
      repo = repos.first

      assert_equal 30, repos.count
      assert_equal "active-record-sinatra", repo[:name]
      assert_equal "https://github.com/rasensio1/active-record-sinatra", repo[:url]
    end
  end

  test "get starred repos for a user" do
    VCR.use_cassette("repo#starred") do
      repos = Repo.starred(users(:ryan))
      repo = repos.first

      assert_equal 6, repos.count
      assert_equal "curriculum", repo[:name]
      assert_equal "https://github.com/turingschool/curriculum", repo[:url]
    end
  end
end
