class Repo

  def self.mine(user)
    data = Github.new.repos.list user: "#{user.screen_name}"
    get_params(data) || []
  end

  def self.starred(user)
    data = Github.new.activity.starring.starred user: "#{user.screen_name}" 
    get_params(data) || []
  end

  private
    def self.get_params(data)
      data.map do |repo|
        {name: repo.name, url: repo.html_url}
      end
    end

end
