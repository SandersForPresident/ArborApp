class MembershipModifier
  class ExistingMembership < StandardError; end
  class NoExistingMembership < StandardError; end

  def self.create_membership(requesting_user:, joinable:, target_user:, role:)
    if requesting_user && !joinable.admin?(requesting_user)
      fail ApplicationService::RequestingUserNotAdmin
    end

    if joinable.contains? target_user
      fail MembershipModifier::ExistingMembership
    end

    Membership.create(user: target_user, joinable: joinable).send("#{role}!")
  end

  def self.update_membership(requesting_user:, joinable:, target_user:, role:)
    unless joinable.admin? requesting_user
      fail ApplicationService::RequestingUserNotAdmin
    end

    unless joinable.contains? target_user
      fail MembershipModifier::NoExistingMembership
    end

    Membership.find_by(user: target_user, joinable: joinable).send("#{role}!")
  end

  def self.destroy_membership(requesting_user:, joinable:, target_user:)
    unless joinable.admin? requesting_user
      fail ApplicationService::RequestingUserNotAdmin
    end

    Membership.where(user: target_user, joinable: joinable).each(&:destroy)
  end
end
