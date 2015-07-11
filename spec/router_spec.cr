require "./spec_helper"

class MyController
  def initialize(ignore)
  end
  
  def action
  end
end

describe Banjo::Router do
  it "should register routes" do
    router = Banjo::Router.new
    router.draw do
      get "/", "my#action"
      get "/aaa", "my#action"
    end
    router.routes["GET"].length.should eq 2
  end
  
  it "should associate a handler" do
    router = Banjo::Router.new
    router.draw do
      get "/", "my#action"
    end
    router.routes["GET"]["/"].handler.class.to_s.should eq "(Banjo::Context -> Nil)"
  end
end
