module Banjo
  class Route
    getter instance
    getter handler
    
    def initialize(@method, @path, @handler)
    end
  end
end