module UserLoggedIn
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    session.key? :user_id
  end
end
