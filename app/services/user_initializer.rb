class UserInitializer
  def self.initialize_and_return_user(auth_hash)
    user = User.auth_find_or_create(
      AuthHashTranslator.for(User, auth_hash).translated_attributes
    )

    verify_or_create_team_and_membership(user: user, auth_hash: auth_hash)

    user
  end

  class << self
    private

    def verify_or_create_team_and_membership(user:, auth_hash:)
      team = Team.auth_find_or_create(
        AuthHashTranslator.for(Team, auth_hash).translated_attributes
      )
      Membership.auth_find_or_create(
        user,
        team,
        AuthHashTranslator.for(Membership, auth_hash).translated_attributes
      )
    end
  end
end
