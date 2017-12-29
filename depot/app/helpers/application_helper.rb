module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def user_logged_in?
    session.key? :user_id
  end

  def hit_counter
    session[request.path] if user_logged_in?
  end
end
