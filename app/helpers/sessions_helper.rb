module SessionsHelper

  #Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  #returns the current logged in user.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #if the user is logged in it will return true, else it will return false
  def logged_in?
    !current_user.nil?
  end

end
