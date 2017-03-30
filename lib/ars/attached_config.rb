# @since 0.1.0
module Ars

  # @since 0.1.0
  module AttachedConfig

    def self.included(subclass)
      subclass.ns.extend(ExtendedMethods)
      subclass.ns.define_singleton_method(:configuration) do
        @configuration ||= subclass.new
      end
    end

    module ExtendedMethods
      # @since 0.1.0
      attr_accessor :configuration

      # @since 0.1.0
      def configure
        yield configuration
      end
    end

  end
end

fib = Enumerator.new do |y|
  a = b = 1
  loop do
    y << a
    a, b = b, a + b
  end
end

#p fib.take(10)

#Enumerable.prepend(OnceEnumerator)
# p Enumerable.ancestors
# p Enumerator.ancestors
# p Array.ancestors

module ActiveSupport
  module Tryable #:nodoc:
    def try(*a, &b)
      try!(*a, &b) if a.empty? || respond_to?(a.first)
    end

    def try!(*a, &b)
      if a.empty? && block_given?
        if b.arity == 0
          instance_eval(&b)
        else
          yield self
        end
      else
        public_send(*a, &b)
      end
    end
  end
end

module Prepender
  def wrap_me(*method_names)
    method_names.each do |m|
      proxy = Module.new do
        define_method(m) do
          puts "the method '#{m}' is about to be called"
          super
        end
      end
      self.prepend proxy
    end
  end
end


