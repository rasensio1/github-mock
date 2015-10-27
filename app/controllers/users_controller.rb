class UsersController < ApplicationController
  helper_method :followers, :following
  def show
   @data = LoginData.new(session[:git_data])
  end

  def followers
    session[:git_data].followers
  end

  def following
    session[:git_data].following
  end
end
