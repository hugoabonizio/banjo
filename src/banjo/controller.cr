module Banjo
  module Controller
    class Base
      property context
      getter response
      property output
      getter mime
      getter code
      
      def initialize(@view = Banjo::View.new)
        @context = Banjo::Context.new
        @response = nil
        @output = ""
        @mime = "text/plain"
        @code = 200
      end
      
      def params
        @context.params
      end
      
      def render(text = nil, html =  nil)
        if !text.nil?
          @output = text
        elsif !html.nil?
          @mime = "text/html"
          @output = html
        end
        @response = HTTP::Response.ok(@mime, @output)
      end
      
      def build_response
        @response = HTTP::Response.ok(@mime, @output)
      end
    end
  end
end