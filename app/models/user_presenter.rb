require  'open-uri'
class UserPresenter 
  attr_accessor :data, :user, :stats

  def initialize(data, user)
    @data = data
    @user = user
    @stats ||= scrape_stats
  end

  def followers
    raw_info["followers"]
  end

  def following
    raw_info["following"]
  end

  def raw_info
    data["extra"]["raw_info"]
  end

  def avatar
    raw_info["avatar_url"]
  end

  def repos
    Repo.mine(user)
  end

  def starred
    Repo.starred(user)
  end

  def my_events
    Event.mine(user)
  end

  def received_events
    Event.received(user)
  end

  def organizations
    result = Github.new.orgs.list user: "#{user.screen_name}"
    orgs = result.map do |org|
      {name: org.login, url: org["repos_url"]}
    end
    return orgs || []
  end

  def scrape_stats
    doc = Nokogiri::HTML(open("https://github.com/#{user.screen_name}"))
    nums = doc.css('span.contrib-number').children.map { |num| num.text }

    { year_commits: nums.first, 
      longest_streak: nums.second, 
      current_streak: nums.third }
  end

end
