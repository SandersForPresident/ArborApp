module AuthHashTranslator
  class User < Translator
    def translate
      {
        email: info['email'],
        name: info['name'],
        avatar: info['image']
      }.with_indifferent_access
    end
  end
end
