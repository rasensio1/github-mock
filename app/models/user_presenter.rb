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

  def starred
    result = Githubn.new.activity.starring.starred user: "#{user.screen_name}" 
    starred = result.map do |repo|
      {name: repo.name, url: repo.html_url}
    end
    return starred || []
  end

  def contribution_summary
  end

  def organizations
  end

end
