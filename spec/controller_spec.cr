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
    ENV["BANJO_VIEWS_PATH"] = "#{__DIR__}/app/views/"
    router = Banjo::Router.new
    router.draw do
      get "/", "my#test_view"
    end
    instance = router.routes["GET"]["/"].instance
    context = Banjo::Context.new
    router.routes["GET"]["/"].handler.call(context)
    instance.build_response
    instance.output.to_s.should eq "hello from ECR"
  end
end
