class SessController < ApplicationController
  def login
  end

  def logout
  end

  def middle
    if (!User.find_by_login(params[:login]).nil?) and (user = User.authenticate(params[:login], params[:password]))
      session[:current_user_id] = user.id
      redirect_to root_url
    end
  end

  def out
    @_current_user = session[:current_user_id] = nil
    redirect_to root_url
  end

end
