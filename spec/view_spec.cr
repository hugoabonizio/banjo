require "./spec_helper"
require "http"

class MyController < Banjo::Controller::Base
end

describe Banjo::View do
  it "should output ECR file" do
    view = Banjo::View.new
    view.loading do
      set_content(load_ecr("#{__DIR__}/app/views/example/test.ecr"))
    end
    view.content.to_s.should eq "hello from ecr file"
  end
  
  it "should output ECR file with loop" do
    view = Banjo::View.new
    view.loading do
      set_content(load_ecr("#{__DIR__}/app/views/example/test2.ecr"))
    end
    view.content.to_s.should eq "
1

2

3
"
    # weird
  end
end
