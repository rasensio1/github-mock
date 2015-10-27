require  'open-uri'
class UserPresenter 
  attr_accessor :data
  def initialize(data, user)
    @data = data
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
    response = open('https://api.github.com/users/rasensio1/starred')
  end
end
