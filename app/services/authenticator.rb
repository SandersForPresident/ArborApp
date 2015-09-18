class Authenticator
  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def authenticate
    @user_init = UserInitializer.new(auth_hash)
    @user_init.verify_team_and_membership
    @user_init.user
  end

  private

  attr_reader :auth_hash
end
