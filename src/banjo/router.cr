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
    
    macro get(path, to)
      register_route("GET", {{ path }}, {{ to }})
    end
    
    macro register_route(method, path, target)
      {% controller = target.split("#").first.capitalize %}
      {% action = target.id.split("#").last %}
      handler = ->(request : Banjo::Context) { {{ controller.id }}Controller.new(request).{{ action.id }} }
      route = Banjo::Route.new("GET", {{ path }}, {{ controller }}, {{ action }}, handler)
      routes[{{ method }}][{{ path }}] = route
    end
  end
end