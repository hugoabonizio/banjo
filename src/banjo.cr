require "kemal"
require "./banjo/*"

module Banjo
  module Routes
    extend self

    def draw
      with self yield
    end

    macro get(path, to)
      get {{path}} do |env|
        {% controller = to.id.split("#").first %}
        {% action = to.id.split("#").last %}
        {{ controller.capitalize.id }}Controller.new.{{ action.id }}.as(String)
      end
    end
  end
end
