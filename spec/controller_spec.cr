require "./spec_helper"
require "http"

class MyController < Banjo::Controller::Base
  def test_text
    render text: "Hello, World!"
  end
  
  def test_html
    render html: "<h1>Hello, World!</h1>"
  end
  
  def test_view
  end
  
  def with_var
    @var1 = 4
    @var2 = "quatro"
    @vars = [1, 2, 3]
  end
end

module Banjo::Router
  get "/", "my#test_view"
  get "/vars", "my#with_var"
end

describe Banjo::Controller::Base do
  it "should access request params" do
    request = HTTP::Request.new("GET", "/?p1=666")
    context = Banjo::Context.new(request)
    controller = MyController.new
    controller.context = context
    controller.params["p1"].should eq("666")
  end
  
  it "should render inline" do
    controller = MyController.new
    
    controller.test_text
    controller.build_response
    controller.output.to_s.should eq "Hello, World!"
    controller.mime.should eq "text/plain"
    
    controller.test_html
    controller.build_response
    controller.output.to_s.should eq "<h1>Hello, World!</h1>"
    controller.mime.should eq "text/html"
  end
  
  it "should render ECR view" do
    instance = $routes["GET"]["/"].instance
    context = Banjo::Context.new
    $routes["GET"]["/"].handler.call(context)
    instance.output.to_s.should eq "hello from ECR"
  end
  
  it "should render ECR with isntance vars" do
    instance = $routes["GET"]["/vars"].instance
    context = Banjo::Context.new
    $routes["GET"]["/vars"].handler.call(context)
    instance.output.to_s.should eq "4
true

> 1

> 2

> 3
"
  end
end
