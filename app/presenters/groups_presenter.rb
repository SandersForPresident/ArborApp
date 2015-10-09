class GroupsPresenter
  def initialize(group:, current_user:)
    @group = group
    @current_user = current_user
  end

  def name
    group.name
  end

  def create_sub_group_button(view)
    view.link_to 'Create Sub-Group',
                 view.new_group_path(
                   parent_group: group,
                   team: group.team
                 ) if group.admin? current_user
  end

  def join_button_or_application_status(view)
    if group.pending_application? current_user
      view.simple_format('Application Pending')
    elsif !group.contains?(current_user)
      join_button(view)
    end
  end

  private

  attr_reader :group, :current_user

  def new_membership
    @new_membership ||= Membership.new(user: current_user, joinable: group)
  end

  def join_button(view)
    view.form_for(new_membership, remote: true) do |f|
      view.concat f.hidden_field :user_id
      view.concat f.hidden_field :group_id, value: new_membership.joinable.id
      view.concat f.submit 'Join Group', class: 'btn btn-default'
    end
  end
end
