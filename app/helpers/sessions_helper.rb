module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  #logs a uSser out by both removing the user_id and remember digest
  #from the cookies as well as deleting the temporary session
  def logout
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    user_id = session[:user_id]
    if user_id
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      success = user && user.authenticated?(cookies[:remember_token])
      if success
        login user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    return user == current_user
  end

  def logged_in?
    #calls the method current_user, not me forgetting @ on the instance variable
    return !current_user.nil?
  end

  def remember(user)
    #generate a random remember_token and save it to the database
    user.remember
    #put an encrytped user id into the browswer's cookies
    cookies.permanent.signed[:user_id] = user.id
    #put the remember token in there as well
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    #this makes a key in the sessions helper called forwarding_url and puts
    #the requested url in there, but only for get requests
    session[:forwarding_url] = request.url if request.get?
  end
end
