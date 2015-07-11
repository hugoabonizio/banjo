module Banjo
  class Route
    getter instance
    getter handler
    
    def initialize(@method, @path, @instance, @handler)
    end
  end
end