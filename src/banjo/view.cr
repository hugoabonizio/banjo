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
      if File.exists? {{ file_name }}
        ecr_output = StringIO.new("")
        embed_ecr({{ file_name }}, "ecr_output")
        ecr_output
      else
        ""
      end
    end
    
    def get_response
      HTTP::Response.ok("text/plain", @content)
    end
  end
end