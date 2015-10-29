class UsersController < ApplicationController
  def show
    @presenter = UserPresenter.new(session[:git_data], current_user)
  end
end
