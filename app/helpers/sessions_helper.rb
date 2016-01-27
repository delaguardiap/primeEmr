module SessionsHelper

  #Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permament.signed[:user_id] = user.id
    cookies.permament[:remember_token] = user.remember_token
  end

  #returns the current logged in user.
  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user.id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user.id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end


  #if the user is logged in it will return true, else it will return false
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
