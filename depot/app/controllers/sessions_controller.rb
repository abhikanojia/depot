class SessionsController < ApplicationController
  skip_before_action :authorize

  def create
    user = User.find_by(name: params[:name])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_user_to_dashboard(user)
    else
      redirect_to login_url, alert: "Invalid username/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged out successfully."
  end

  private

    def redirect_user_to_dashboard(user)
      if user.role.eql? 'admin'
        redirect_to admin_reports_url
      else
        redirect_to admin_url
      end
    end
end
