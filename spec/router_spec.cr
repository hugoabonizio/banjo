require "./spec_helper"

class MyController
  def action
  end
end

$routes = {
  "GET": {} of String => Banjo::Route
  "POST": {} of String => Banjo::Route
}

module Banjo::Router
  get "/", "my#action"
  get "/aaa", "my#action"
  post "/bbb", "my#action"
end

describe Banjo::Router do
  it "should register routes" do
    $routes["GET"].length.should eq 2
    $routes["POST"].length.should eq 1
  end
  
  it "should associate a handler" do
    $routes["GET"]["/"].handler.class.to_s.should eq "(Banjo::Context -> MyController)"
    $routes["POST"]["/bbb"].handler.class.to_s.should eq "(Banjo::Context -> MyController)"
  end
end
