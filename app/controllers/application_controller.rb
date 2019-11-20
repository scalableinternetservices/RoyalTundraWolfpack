class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    render html: 'Hello world'
  end

  # def current_user
  #   u = User.find_by(id: session[:user_id])
  # end

  # def authenticate_user
  #   if !current_user
  #     redirect_to signin_path, notice: "You must be signed in to do that!"
  #   end
  # end
  protected 

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username])
    end
end
