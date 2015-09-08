class SkillsController < ApplicationController
  def show
    @skill = Skill.find(params[:id])
    @teams = @skill.teams
  end
end
