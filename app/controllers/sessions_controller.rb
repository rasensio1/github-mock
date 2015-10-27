class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(omni_data)
      session[:user_id] = user.id
      session[:git_data] = omni_data
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    def omni_data
      request.env["omniauth.auth"]
    end
end
