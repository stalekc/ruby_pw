class LangController < ApplicationController
  def change
    session[:lang] = params[:l]
    redirect_to root_url
  end
end
