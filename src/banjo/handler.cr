module Banjo
  class Handler < HTTP::Handler
    def call(request)
      response = handle_request(request)
      response || call_next(request)
    end
    
    def handle_request(request)
      begin
        uri = URI.parse(request.path)
        handler = $routes[request.method.upcase][uri.path].handler
        ctx = Context.new(request)
        instance = handler.call(ctx)
        instance.build_response
        instance.response
      rescue
        HTTP::Response.not_found
      end
    end
  end
end