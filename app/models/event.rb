class Event
  def self.my_events(user)
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
    @repo_url   = "ttps://github.com/#{data.repo.name}"
    @repo_name  = data.repo.name
    @created_at = data.created_at
    @user = find_user
  end

  def find_user
   # user_paths = {"CreateEvent" => lambda {data.actor.login},
   #  "PullRequestEvent" => lambda {data.actor.login},
   #  "PushEvent" => lambda {data.actor.login}
   # }
   # user_paths[data.type].call
     data.actor.login 
  end

  def type
    #add Delete, Issues
    types = {"CreateEvent" => lambda {"Create " + data.payload.ref_type.humanize},
     "PullRequestEvent" => lambda {"Pull Request"},
     "PushEvent" => lambda {"Push"}
    }
    types.default = lambda {data.type}

    types[data.type].call
  end
end
