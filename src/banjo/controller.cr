module Banjo
  module Controller
    class Base
      def initialize(@context = Banjo::Context.new)
      end
      
      def params
        @context.params
      end
    end
  end
end