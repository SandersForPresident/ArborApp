class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def create
    @group = JoinableBuilder.build_group(requesting_user: current_user,
                                         attributes: group_params)

    if @group.save
      redirect_to @group
    else
      render 'new'
    end
  rescue JoinableBuilder::RequestingUserNotAdmin
    render 'new'
  end

  def new
    @group = Group.new
    @team_id = params[:team]
    @parent_group_id = params[:parent_group] if params[:parent_group]
  end

  def show
    @group = Group.find(params[:id])
    @admin = @group.admin? current_user
  end

  private

  def group_params
    params.require(:group).permit(:name, :team_id, :parent_group_id)
  end
end
