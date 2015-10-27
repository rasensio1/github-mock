require  'open-uri'
class UserPresenter 
  attr_accessor :data, :user

  def initialize(data, user)
    @data = data
    @user = user
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

  def starred
    result = Github.new.activity.starring.starred user: "#{user.screen_name}" 
    list = result.map do |repo|
      {name: repo.name, url: repo.html_url}
    end
    return list || []
  end

  def contribution_summary
    github.repos.stats.code_frequency
  end

  def organizations
    result = Github.new.orgs.list user: "#{user.screen_name}"
    orgs = result.map do |org|
      {name: org.login, url: org["repos_url"]}
    end
    return orgs || []
  end

  def my_events
    Event.my_events(user)
  end

  def received_events
    Event.received(user)
  end

end
