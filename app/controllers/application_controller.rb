class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_locale
  def current_user
    if session[:current_user_id]
      @current_user ||= User.find(session[:current_user_id])
    else
      @current_user = nil
    end
  end

  def set_locale
    I18n.locale = session[:lang] || I18n.default_locale
  end
end
