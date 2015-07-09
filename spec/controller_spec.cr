require "./spec_helper"
require "http"

class MyController < Banjo::Controller::Base
end

describe Banjo::Controller::Base do
  it "should access request params" do
    request = HTTP::Request.new("GET", "/?p1=666")
    context = Banjo::Context.new(request)
    controller = MyController.new(context)
    controller.params["p1"].should eq("666")
  end
end
