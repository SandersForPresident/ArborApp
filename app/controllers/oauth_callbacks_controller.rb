class OauthCallbacksController < ApplicationController
  def show
    @user = Authenticator.new(auth_hash).authenticate
    session[:current_user] = @user.id
    redirect_to root_path, notice: t('.success', email: @user.email)
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
