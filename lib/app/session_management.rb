module App::SessionManagement
  def current_session
    return @current_session if @current_session
    @current_session = UserSession.find
  end

  def current_user
    return @current_user if @current_user
    if current_session
      @current_user = current_session.record
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end