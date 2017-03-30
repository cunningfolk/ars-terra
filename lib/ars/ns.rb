module Ars
  module NS
    def ns
      namespace = name.split('::'.freeze)[0..-2].join('::'.freeze)
      const_get namespace unless namespace.empty?
    end
  end
end

module Ars
  module EnumerableModule
    include Enumerable
    def each(with=:dwim)
      case with
      when :dwim && self == self.ancestors || :namespace
        enum_for :each_namespace
      when :dwim || :ancestors
        enum_for :each_ancestor
      when :nesting
        enum_for :each_nesting
      end
    end

    def each_namespace
    end

    def each_ancestor
    end

    def each_nesting
    end

    module ModuleSingleton
    end
    module ClassSingleton
    end
  end
end
Module.include Ars::NS
Module.include Ars::EnumerableModule
