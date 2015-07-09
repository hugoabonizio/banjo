module Banjo
  class Router
    getter routes
    
    def initialize
      @routes = {
        "GET": {} of String => Route
        "POST": {} of String => Route
      }
    end
    
    def draw(&block)
      with self yield
    end
    
    def get(path, to)
      
    end
    
    macro get(path, target)
      handler = ->(request : Banjo::Context) { {{ target.split("#").first.capitalize.id }}Controller.new(request).{{target.id.split("#").last.id}} }
      route = Banjo::Route.new("GET", {{ path }}, {{ target.split("#").first.capitalize }}, {{ target.id.split("#").last }}, handler)
      routes["GET"][{{ path }}] = route
    end
  end
end