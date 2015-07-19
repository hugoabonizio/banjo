module Banjo
  class Route
    getter method, path, handler
    
    def initialize(@method, @path, @handler)
    end
  end
end