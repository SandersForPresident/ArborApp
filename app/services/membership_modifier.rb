class MembershipModifier
  class ExistingMembership < StandardError; end
  class NoExistingMembership < StandardError; end

  def self.create_membership(requesting_user:, joinable:, target_user:, admin:)
    return unless joinable.admin? requesting_user

    if joinable.contains? target_user
      fail MembershipModifier::ExistingMembership
    end

    if admin
      Membership.create(user: target_user, joinable: joinable).admin!
    else
      Membership.create(user: target_user, joinable: joinable).member!
    end
  end

  def self.update_membership(requesting_user:, joinable:, target_user:, admin:)
    return unless joinable.admin? requesting_user

    unless joinable.contains? target_user
      fail MembershipModifier::NoExistingMembership
    end

    if admin
      Membership.find_by(user: target_user, joinable: joinable).admin!
    else
      Membership.find_by(user: target_user, joinable: joinable).member!
    end
  end

  def self.destroy_membership(requesting_user:, joinable:, target_user:)
    return unless joinable.admin? requesting_user

    Membership.where(user: target_user, joinable: joinable).each(&:destroy)
  end
end
