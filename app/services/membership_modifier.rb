class MembershipModifier
  class RequestingUserNotAdmin < StandardError; end
  class ExistingMembership < StandardError; end
  class NoExistingMembership < StandardError; end

  def self.find_or_initialize_membership(requesting_user:, joinable:, target_user:, attributes:)
    if requesting_user && !joinable.admin?(requesting_user)
      fail MembershipModifier::RequestingUserNotAdmin
    end

    if joinable.contains? target_user
      fail MembershipModifier::ExistingMembership
    end

    attributes = { user: target_user, joinable: joinable }.merge(attributes)
    ModelFinder.for(Membership, attributes).find
  end

  def self.create_membership(requesting_user:, joinable:, target_user:, attributes:)
    if requesting_user && !joinable.admin?(requesting_user)
      fail MembershipModifier::RequestingUserNotAdmin
    end

    if joinable.contains? target_user
      fail MembershipModifier::ExistingMembership
    end

    attributes = { user: target_user, joinable: joinable }.merge(attributes)

    Membership.create(attributes)
  end

  def self.update_membership(requesting_user:, joinable:, target_user:, attributes:)
    unless joinable.admin? requesting_user
      fail MembershipModifier::RequestingUserNotAdmin
    end

    unless joinable.contains? target_user
      fail MembershipModifier::NoExistingMembership
    end
    attributes = { user: target_user, joinable: joinable }.merge(attributes)
    Membership.find_by(user: target_user, joinable: joinable).update(attributes)
  end

  def self.destroy_membership(requesting_user:, joinable:, target_user:)
    unless joinable.admin? requesting_user
      fail MembershipModifier::RequestingUserNotAdmin
    end

    Membership.where(user: target_user, joinable: joinable).each(&:destroy)
  end

  private

  def self.find_or_initialize(user, joinable, attributes)
    attributes = { user: user, joinable: joinable }.merge(attributes)
    Membership.find_or_initialize_by(
      user: user,
      joinable: joinable
    ).tap do |m|
      m.update!(attributes)
    end
  end

  def default_attributes
    {
      role: 'member'
    }
  end
end
