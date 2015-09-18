class UserInitializer
  def self.initialize_and_return_user(auth_hash)
    user = ModelFinder.for(
      User,
      AuthHashTranslator.for(User, auth_hash).translated_attributes
    ).find_or_initialize

    verify_or_create_team_and_membership(user: user, auth_hash: auth_hash)

    user
  end

  class << self
    private

    def verify_or_create_team_and_membership(user:, auth_hash:)
      JoinableBuilder.build_team(
        requesting_user: user,
        attributes:
        AuthHashTranslator.for(Team, auth_hash).translated_attributes,
        membership_attributes:
        AuthHashTranslator.for(Membership, auth_hash).translated_attributes
      )
    end
  end
end
