class SessionsController < ApplicationController
  def destroy
    sign_out
    redirect_to root_path, notice: t('.success')
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
