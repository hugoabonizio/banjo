module Banjo
  class Context
    
    def initialize(@request = HTTP::Request.new("GET", "/"))
      @_params = {} of String => String
    end
    
    def params
      if @_params.empty?
        # query string
        query = @request.uri.query.to_s
        query.scan /([\w]+)=([\w]*)/ do |m|
          @_params[m[1]] = m[2]
        end
    
        # post data
        body = @request.body.to_s
        body.scan /([\w]+)=([\w]*)/ do |m|
          @_params[m[1]] = m[2]
        end
      end
      @_params
    end
  end
end