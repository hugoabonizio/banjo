require "./spec_helper"

describe Banjo::Controller::Base do
  it "should associate a handler" do
    test = 1
    handler = ->(ctx : Banjo::Context){ test = 2; nil }
    route = Banjo::Route.new("GET", "/", "welcome", "index", handler)
    route.handler.call(Banjo::Context.new)
    test.should eq 2
  end
end
