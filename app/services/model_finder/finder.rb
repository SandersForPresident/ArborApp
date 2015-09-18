module ModelFinder
  class Finder
    class SubclassMustImplimentFind < NotImplementedError; end
    def initialize(info)
      @info = info
    end

    def find
      fail Finder::SubclassMustImplimentFind
    end

    protected

    attr_reader :info

    def update(model)
      model.update!(info)
    end
  end
end
