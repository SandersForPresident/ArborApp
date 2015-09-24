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

  def approve
    @membership = Membership.find_by_id(params[:id])
    if @membership && @membership.joinable.admin?(current_user)
      @membership.approve!
      render 'approve.js'
    else
      render 'approve_failure.js'
    end
  end

  def deny
    @membership = Membership.find_by_id(params[:id])
    if @membership && @membership.joinable.admin?(current_user)
      @membership.deny!
      render 'deny.js'
    else
      render 'deny_failure.js'
    end
  end

  private

  def joinable_from_params(params)
    Group.find_by_id(params[:membership][:group_id]) ||
      Team.find_by_id(params[:membership][:team_id]) ||
      nil
  end
end
