class MainController < ApplicationController

  respond_to :json

  def main
  end

  def view
    @answer = [t(:'We`ve done:'), '', t(:'Messages wrote -'), Message.count, t(:'Users created -'), User.count, t(:'Forums created -'), Forum.count]
    respond_with @answer do |format|
      format.html
      format.json do
        render json: {type: @answer.class, value: @answer}
      end
    end
  end
end
