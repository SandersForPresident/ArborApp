class UserFinder
  def initialize(user_info)
    @user_info = user_info
  end

  def user
    find_or_create_user
  end

  private

  attr_reader :user_info

  def find_or_create_user
    User.find_or_initialize_by(
      email: user_info['email']
    ).tap do |user|
      user_update(user)
    end
  end

  def user_update(user)
    user.update!(
      avatar: user_info['image'],
      name: user_info['name']
    )
  end
end
