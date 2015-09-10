class SkillsController < ApplicationController
  def show
    @skill = Skill.find(params[:id])
    @groups = @skill.groups
  end
end
