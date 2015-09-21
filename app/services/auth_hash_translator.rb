module AuthHashTranslator
  def self.for(model_name, auth_hash)
    klass_for(model_name).new(auth_hash)
  end

  def self.klass_for(model_name)
    "AuthHashTranslator::#{model_name}".constantize
  end
end
