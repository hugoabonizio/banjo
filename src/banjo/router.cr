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
      view = Banjo::View.new
      view.loading do
        set_content(load_ecr("{{ Banjo::VIEWS_PATH.id }}{{ controller.downcase.id }}/{{ action.downcase.id }}.ecr"))
      end
  
      instance = {{ controller.id }}Controller.new(view)
      handler = ->(context : Banjo::Context) {
        instance.context = context
        instance.{{ action.id }}
      }
      
      route = Banjo::Route.new("GET", {{ path }}, instance, handler)
      routes[{{ method }}][{{ path }}] = route
    end
  end
end