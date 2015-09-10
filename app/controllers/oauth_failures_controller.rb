class OauthFailuresController < ApplicationController
  def show
    redirect_to root_path, alert: t('.failed')
  end
end
