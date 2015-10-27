class Event
  def self.my_events(user)
    result = Github.new.activity.events.performed "#{user.screen_name}"
    sorted = result.sort_by { |event| event.created_at }.first(10).reverse

    events = sorted.map do |event|
      {type: event.type , 
       url: "https://github.com/#{event.repo.name}", 
       repo_name: event.repo.name }
    end
  end

  def self.received(user)
    result = Github.new.activity.events.received "#{user.screen_name}"
    sorted = result.sort_by { |event| event.created_at }.first(10).reverse

    events = sorted.map do |event|
      {type: event.type,
       url: "https://github.com/#{event.repo.name}",
       repo_name: event.repo.name }
    end
  end
end
