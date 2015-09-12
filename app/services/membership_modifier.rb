class MembershipModifier
  def self.create_membership(requesting_user:, joinable:, target_user:, admin:)
    return unless joinable.admin? requesting_user

    if admin
      Membership.create(user: target_user, joinable: joinable).admin!
    else
      Membership.create(user: target_user, joinable: joinable).member!
    end
  end

  def self.destroy_membership(requesting_user:, joinable:, target_user:)
    return unless joinable.admin? requesting_user

    Membership.where(user: target_user, joinable: joinable).each(&:destroy)
  end
end
