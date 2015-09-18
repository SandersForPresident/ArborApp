module AuthHashTranslator
  class User < Translator
    def translated_attributes
      {
        email: info['email'],
        name: info['name'],
        avatar: info['image']
      }.with_indifferent_access
    end
  end
end
