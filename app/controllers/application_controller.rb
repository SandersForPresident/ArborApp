class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  protect_from_forgery with: :exception

  def current_user
    token = cookies.signed[:auth_token]
    @current_user ||= User.find_by(auth_token: token) if token
  end
end
