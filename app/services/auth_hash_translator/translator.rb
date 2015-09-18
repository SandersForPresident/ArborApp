module AuthHashTranslator
  class Translator
    class SubclassMustImplimentTranslate < NotImplementedError; end
    def initialize(auth_hash)
      @auth_hash = auth_hash
    end

    def translate
      fail Translator::SubclassMustImplimentTranslate
    end

    protected

    attr_reader :auth_hash

    def info
      auth_hash['info']
    end
  end
end
