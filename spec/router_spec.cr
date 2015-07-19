require "./spec_helper"

class MyController
  def action
  end
  
  def root
  end
end

$routes = {
  "GET": {} of String => Banjo::Route
  "POST": {} of String => Banjo::Route
}

module Banjo::Router
  root "my#action"
  get "/test1", "my#action"
  get "/test2", "my#action"
  post "/test3", "my#action"
end

describe Banjo::Router do
  it "should register routes" do
    $routes["GET"].length.should eq 3
    $routes["POST"].length.should eq 2
  end
  
  it "should associate a handler" do
    $routes["GET"]["/test1"].handler.class.to_s.should eq "(Banjo::Context -> MyController)"
    $routes["POST"]["/test3"].handler.class.to_s.should eq "(Banjo::Context -> MyController)"
  end
  
  it "should register root route" do
    $routes["GET"]["/"].path.should eq "/"
  end
end
