module ApplicationHelper
  def login_path(provider)
    "/auth/#{provider}"
  end
end
