class OauthCallbacksController < ApplicationController
  def show
    user = UserInitializer.initialize_and_return_user(auth_hash)
    sign_in(user)
    redirect_to root_path, notice: t('.success', email: user.email)
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
