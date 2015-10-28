class Repo
  def self.github
    Github.new
  end

  def self.mine(user)
    data = github.repos.list user: "#{user.screen_name}"
    get_params(data) || []
  end

  def self.starred(user)
    data = github.activity.starring.starred user: "#{user.screen_name}"
    get_params(data) || []
  end

  private
    def self.get_params(data)
      data.map do |repo|
        {name: repo.name, url: repo.html_url}
      end
    end
end
