class UsersController < ApplicationController
  helper_method :followers, :following
  def show
    @presenter = UserPresenter.new(session[:git_data], current_user)
  end
end
