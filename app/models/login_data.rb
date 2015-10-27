class LoginData
  attr_accessor :data
  def initialize(data)
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
end
