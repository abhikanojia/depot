class ApplicationController < ActionController::Base
  include UserLoggedIn
  include AutoSessionTimeout

  auto_session_timeout

  before_action :set_i18n_locale_from_params, if: '!user_logged_in?'
  before_action :set_i18n_locale_from_user_preference, if: :user_logged_in?
  protect_from_forgery with: :exception
  before_action :authorize
  around_action :append_response_time_in_header
  before_action  :increment_pageviews_counter

  protected
    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: t('.login')
      end
    end

    def set_i18n_locale_from_user_preference
      I18n.locale = current_user.language_preference
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def append_response_time_in_header
      start = Time.now
      yield
      response.headers['x-responded-in'] = (Time.now - start).seconds.to_s.concat("seconds")
    end

    def increment_pageviews_counter
      if !session[request.path]
        session[request.path] = 1
      else
        session[request.path] += 1
      end
    end
end
