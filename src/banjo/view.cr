require "ecr"
require "ecr/macros"

module Banjo
  class View
    getter content
    
    def initialize
      @content = ""
    end
    
    def set_content(value)
      @content = value
    end
    
    def loading(&block)
      with self yield
    end
    
    macro load_ecr(file_name)
      {% result_file_name = run("./view/load_file_if_exists", {{file_name}}).stringify %}
      ecr_output = StringIO.new("")
      embed_ecr({{ result_file_name }}, "ecr_output")
      ecr_output
    end
  end
end