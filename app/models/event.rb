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

  attr_reader :data, :repo_url, :repo_name, :created_at, :user, :type

  def initialize(data)
    @data       = data
    @repo_url   = "https://github.com/#{data.repo.name}"
    @repo_name  = data.repo.name
    @created_at = data.created_at
    @user = find_user
    @type = get_type(data)
  end

  def find_user
    data.actor.login
  end

  def get_type(info)
    types = {"CreateEvent" => lambda {"Create " + info.payload.ref_type.humanize},
     "PullRequestEvent" => lambda {"Pull Request"},
     "PushEvent" => lambda {"Push"},
     "DeleteEvent" => lambda {"Delete" + info.payload.ref_type.humanize},
     "IssuesEvent" => lambda {"Event" + info.payload.action.humanize}
    }
    types.default = lambda { info.type }
    types[info.type].call
  end
end
