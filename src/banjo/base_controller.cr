class Banjo::BaseController
  macro original_render(arg)
    ::render {{ arg }}
  end

  macro render(action)
    {% resource = @type.stringify.split("Controller").first %}
    original_render "./app/views/{{ resource.downcase.id }}/{{ action.id }}.ecr"
  end
end
