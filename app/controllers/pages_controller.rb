class PagesController < ApplicationController
  def home
    @skills = Skill.all
  end
end
