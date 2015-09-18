class UserInitializer
  attr_reader :user

  def initialize(auth_hash)
    @auth_hash = auth_hash
    @user = ModelFinder.for(
      User,
      AuthHashTranslator.for(User, auth_hash).translate
    ).find
  end

  def verify_team_and_membership
    JoinableBuilder.build_team(
      requesting_user: @user,
      attributes: AuthHashTranslator.for(Team, auth_hash).translate,
      membership_attributes: AuthHashTranslator.for(Membership, auth_hash).translate
    )
  end

  private

  attr_reader :auth_hash
end
