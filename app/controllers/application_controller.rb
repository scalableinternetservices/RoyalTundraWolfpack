class ApplicationController < ActionController::Base
  def index
    render html: 'Hello world'
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if !current_user
      redirect_to signin_path, notice: "You must be signed in to do that!"
    end
  end
end
