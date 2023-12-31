module SessionsHelper
  # Logs in the given user.
  def log_in user
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id
    elsif user_id = cookies.encrypted[:user_id]
      user = User.find_by(id: user_id)
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    current_user.present?
  end

  # Logs out the current user.
  def log_out
    session.delete :user_id
    @current_user = nil
  end

  # Returns true if the given user is the current user.
  def current_user? user
    user == current_user
  end
end
