module Banjo
  module Controller
    class Base
      getter response
      
      def initialize(@context = Banjo::Context.new)
        @response :: HTTP::Response
      end
      
      def params
        @context.params
      end
      
      def render(text = nil, html =  nil)
        if !text.nil?
          @response = HTTP::Response.ok("text/plain", text)
        elsif !html.nil?
          @response = HTTP::Response.ok("text/html", html)
        end
      end
    end
  end
end