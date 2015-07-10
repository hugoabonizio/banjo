require "./spec_helper"
require "http"

class MyController < Banjo::Controller::Base
  def test_text
    render text: "Hello, World!"
  end
  
  def test_html
    render html: "<h1>Hello, World!</h1>"
  end
end

describe Banjo::Controller::Base do
  it "should access request params" do
    request = HTTP::Request.new("GET", "/?p1=666")
    context = Banjo::Context.new(request)
    controller = MyController.new(context)
    controller.params["p1"].should eq("666")
  end
  
  it "should render inline" do
    controller = MyController.new(Banjo::Context.new)
    
    controller.test_text
    controller.response.body.should eq "Hello, World!"
    controller.response.headers["Content-type"].should eq "text/plain"
    
    controller.test_html
    controller.response.body.should eq "<h1>Hello, World!</h1>"
    controller.response.headers["Content-type"].should eq "text/html"
  end
end
