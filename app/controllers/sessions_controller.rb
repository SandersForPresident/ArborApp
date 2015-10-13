class SessionsController < ApplicationController
  def destroy
    current_user.regenerate_auth_token if current_user
    cookies.delete(:auth_token)
    sign_out
    redirect_to root_path, notice: t('.success')
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
