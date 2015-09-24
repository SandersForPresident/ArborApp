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

  def pending_applications(view)
    return unless group.pending_applications?
    view.concat view.simple_format('Pending Membership Applications')
    pending_applications_list(view)
    nil
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

  def pending_applications_list(view)
    pending_applications = group.pending_applications

    return unless pending_applications.any?

    view.concat '<ul>'
    pending_applications.each do |pending_application|
      pending_application_list_item(view, pending_application)
    end
    view.concat '</ul>'
  end

  def pending_application_list_item(view, pending_application)
    view.concat '<li id="pending-membership-{pending_application.id}">'
    view.concat pending_application_name(view, pending_application)
    view.concat pending_application_approve_button(view, pending_application)
    view.concat pending_application_deny_button(view, pending_application)
    view.concat '</li>'
  end

  def pending_application_name(view, pending_application)
    view.simple_format(pending_application.user.name)
  end

  def pending_application_approve_button(view, pending_application)
    view.button_to [:approve, pending_application], remote: true, method: :put do
      'Approve'
    end
  end

  def pending_application_deny_button(view, pending_application)
    view.button_to [:deny, pending_application], remote: true, method: :put do
      'Deny'
    end
  end
end
