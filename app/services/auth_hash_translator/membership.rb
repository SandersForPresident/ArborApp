module AuthHashTranslator
  class Membership < Translator
    def translate
      {
        slack_uid: auth_hash['uid'],
        slack_access_token: auth_hash['credentials']['token'],
        role: role
      }.with_indifferent_access
    end

    private

    def role
      return 'admin' if auth_hash['info']['is_admin']
      'member'
    end
  end
end
