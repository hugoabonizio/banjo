module Banjo
  class Route
    getter controller
    getter action
    getter handler
    
    def initialize(@method, @path, @controller, @action, @handler : (Banjo::Context -> ))
    end
  end
end