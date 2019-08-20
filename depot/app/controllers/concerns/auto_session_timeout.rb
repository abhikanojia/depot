module AutoSessionTimeout
  module ClassMethods
    def auto_session_timeout(timeout_time = 1.hour)
      prepend_before_action do |c|
        if c.session[:session_timeout_at] && c.session[:session_timeout_at] < Time.now
          c.send :reset_session
        else
          c.session[:session_timeout_at] = Time.now + timeout_time
        end
      end
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
  end
end
