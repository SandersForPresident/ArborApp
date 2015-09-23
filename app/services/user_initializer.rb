class UserInitializer
  def self.initialize_and_return_user(auth_hash)
    user = User.find_or_create_with_auth_hash(
      AuthHashTranslator.for(User, auth_hash).translated_attributes
    )

    verify_or_create_team_and_membership(user: user, auth_hash: auth_hash)

    user
  end

  class << self
    private

    def verify_or_create_team_and_membership(user:, auth_hash:)
      team = Team.find_or_create_with_auth_hash(
        AuthHashTranslator.for(Team, auth_hash).translated_attributes
      )
      Membership.find_or_create_with_auth_hash(
        user: user,
        team: team,
        auth_membership_hash:
        AuthHashTranslator.for(Membership, auth_hash).translated_attributes
      ).approve!
    end
  end
end
