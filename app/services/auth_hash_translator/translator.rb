module AuthHashTranslator
  class Translator
    class SubclassMustImplimentTranslatedAttributes < NotImplementedError; end
    def initialize(auth_hash)
      @auth_hash = auth_hash
    end

    def translated_attributes
      fail Translator::SubclassMustImplimentTranslatedAttributes
    end

    protected

    attr_reader :auth_hash

    def info
      auth_hash['info']
    end
  end
end
