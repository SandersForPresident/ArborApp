module ApplicationHelper
  def login_path(provider)
    "/auth/#{provider}"
  end

  def sign_in_link(user)
    if user.present?
      link_to t('application.navigation.sign_out'), logout_path,
        class: 'navbar-brand'
    else
      link_to t('application.navigation.sign_in'), login_path('slack'),
        class: 'navbar-brand'
    end
  end
end
