module ModelFinder
  def self.for(model_name, info)
    klass_for(model_name).new(info)
  end

  def self.klass_for(model_name)
    "ModelFinder::#{model_name}".constantize
  end
end
