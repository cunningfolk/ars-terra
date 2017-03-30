require 'blankslate'

class Functioniser < BlankSlate
  class Func
    def initialize(method)
      @method = method
    end

    def to_proc
      ->(x, *args) { x.send(@method, *args)}
    end
  end

  def method_missing(method)
    Func.new(method)
  end
end

# Not sure if it's safe to use $_, or if it's used for something else...
$_ = Functioniser.new

puts [1,2,3].map(&$_.to_s).inspect
# => ["1", "2", "3"]

puts [1,2,3].inject(&$_.+).inspect
# => 6
