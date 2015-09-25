class MembershipsController < ApplicationController
  def create
    params[:membership] ||= {}

    user = User.find_by_id(params[:membership][:user_id])
    joinable = joinable_from_params(params)
    membership = Membership.create(user: user, joinable: joinable)

    if membership.valid?
      render 'create.js'
    else
      render 'create_failure.js'
    end
  end

  def update
    state_transition = params[:membership][:state_transition]
    @membership = Membership.find_by_id(params[:id])
    if @membership && @membership.joinable.admin?(current_user) && state_transition
      @membership.send("#{state_transition}!")
      render "#{state_transition}.js"
    else
      render "#{state_transition}_failure.js"
    end
  end

  private

  def joinable_from_params(params)
    Group.find_by_id(params[:membership][:group_id]) ||
      Team.find_by_id(params[:membership][:team_id]) ||
      nil
  end
end
