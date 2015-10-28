class Event
  def self.mine(user)
    result = Github.new.activity.events.performed "#{user.screen_name}"
    sorted = result.sort_by { |event| event.created_at }.first(10).reverse

    events = sorted.map do |event_data|
      Event.new(event_data)
    end
  end

  def self.received(user)
    result = Github.new.activity.events.received "#{user.screen_name}"
    sorted = result.sort_by { |event| event.created_at }.first(10).reverse

    events = sorted.map do |event_data|
      Event.new(event_data)
    end
  end

  attr_reader :data, :repo_url, :repo_name, :created_at, :user

  def initialize(data)
    @data       = data
    @repo_url   = "https://github.com/#{data.repo.name}"
    @repo_name  = data.repo.name
    @created_at = data.created_at
    @user = find_user
  end

  def find_user
    data.actor.login
  end

  def type
    types = {"CreateEvent" => lambda {"Create " + data.payload.ref_type.humanize},
     "PullRequestEvent" => lambda {"Pull Request"},
     "PushEvent" => lambda {"Push"},
     "DeleteEvent" => lambda {"Delete" + data.payload.ref_type.humanize},
     "IssuesEvent" => lambda {"Event" + data.payload.action.humanize}
    }
    types.default = lambda { data.type }
    types[data.type].call
  end
end
