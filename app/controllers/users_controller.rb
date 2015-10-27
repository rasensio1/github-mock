class UsersController < ApplicationController
  helper_method :followers, :following
  def show
   @presenter = UserPresenter.new(session[:git_data], current_user)
  end

  def followers
    session[:git_data].followers
  end

  def following
    session[:git_data].following
  end
end
