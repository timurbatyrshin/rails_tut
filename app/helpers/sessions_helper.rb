module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token( cookies[:remember_token] )
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !self.current_user.nil?
  end

  def sign_out
    cookies.permanent[:remember_token] = nil
    self.current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def non_signed_in_user
    if signed_in?
      redirect_to user_path(current_user)
    end
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
