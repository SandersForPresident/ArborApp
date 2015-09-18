module ModelFinder
  class Finder
    class SubclassMustImplimentFindOrInitialize < NotImplementedError; end

    def initialize(info)
      @info = info
    end

    def find_or_initialize
      fail Finder::SubclassMustImplimentFindOrInitialize
    end

    protected

    attr_reader :info

    def update(model)
      model.update!(info)
    end
  end
end
