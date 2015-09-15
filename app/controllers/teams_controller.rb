class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @admin = @team.admin? current_user
  end
end
