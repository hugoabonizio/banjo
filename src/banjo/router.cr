module Banjo
  $routes = {
     "GET": {} of String => Route
     "POST": {} of String => Route
  }
  
  module Router
    macro load_ecr(file_name)
      {% result_file_name = run("./view/load_file_if_exists", {{file_name}}).stringify %}
      ecr_output = StringIO.new("")
      embed_ecr({{ result_file_name }}, "ecr_output")
      ecr_output
    end
    
    macro root(to)
      get("/", {{ to }})
      post("/", {{ to }})
    end

    macro get(path, to)
      register_route("GET", {{ path }}, {{ to }})
    end
    
    macro post(path, to)
      register_route("POST", {{ path }}, {{ to }})
    end

    macro register_route(method, path, target)
      {% controller = target.split("#").first.capitalize %}
      {% action = target.id.split("#").last %}

      class ::{{ controller.id }}Controller
        def to_s_{{ action.id }}
          {% file_name = "#{Banjo::VIEWS_PATH.id }#{ controller.downcase.id }/#{ action.downcase.id }.ecr" %}
          {% result_file_name = run("./view/load_file_if_exists", file_name.id).stringify %}
          ecr_output = StringIO.new("")
          embed_ecr({{ result_file_name }}, "ecr_output")
          ecr_output.to_s
        end
      end

      handler = ->(context : Banjo::Context) {
        instance = {{ controller.id }}Controller.new
        instance.context = context
        instance.{{ action.id }}
        if instance.output.try(&.empty?)
          instance.output = instance.to_s_{{ action.id }}
        end
        instance
      }
      
      route = Banjo::Route.new({{ method }}, {{ path }}, handler)
      $routes[{{ method }}][{{ path }}] = route
    end
  end
end