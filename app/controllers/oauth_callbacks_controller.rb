class OauthCallbacksController < ApplicationController
  def show
    user = UserInitializer.initialize_and_return_user(auth_hash)
    sign_in(user)
    set_token(user)
    redirect_to root_path, notice: t('.success', email: user.email)
  end

  private

  def set_token(user)
    user.regenerate_auth_token
    cookies.signed[:auth_token] = {
      value: user.auth_token,
      expires: 1.week.from_now.utc
    }
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
