module UserLoggedIn
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user.role.eql? 'admin'
  end
end
