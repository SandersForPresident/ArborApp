module AuthHashTranslator
  class Membership < Translator
    def translated_attributes
      {
        slack_uid: auth_hash['uid'],
        slack_access_token: auth_hash['credentials']['token'],
        role: role
      }.with_indifferent_access
    end

    private

    def role
      return 'admin' if info['is_admin']
      'member'
    end
  end
end
