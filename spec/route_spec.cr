require "./spec_helper"

class MyController
end

describe Banjo::Route do
  it "should associate a handler" do
    test = 1
    handler = ->(ctx : Banjo::Context){ test = 2; nil }
    route = Banjo::Route.new("GET", "/", handler)
    route.handler.call(Banjo::Context.new)
    test.should eq 2
  end
end
