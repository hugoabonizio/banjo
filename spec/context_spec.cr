require "./spec_helper"
require "http"

describe Banjo::Context do
  it "should parse empty query strings" do
    request = HTTP::Request.new("GET", "/")
    context = Banjo::Context.new(request)
    context.params.empty?.should eq(true)
  end
  
  it "should parse query strings" do
    request = HTTP::Request.new("GET", "/?param1=1&param2=a2")
    context = Banjo::Context.new(request)
    context.params["param1"].should eq("1")
    context.params["param2"].should eq("a2")
  end
  
  it "should parse post body" do
    request = HTTP::Request.new("POST", "/", body: "param1=1&param2=a2")
    context = Banjo::Context.new(request)
    context.params["param1"].should eq("1")
    context.params["param2"].should eq("a2")
  end
  
  it "should parse both query strings and body" do
    request = HTTP::Request.new("POST", "/?p1=666&p2=aaa", body: "p3=hugo&p4=abonizio")
    context = Banjo::Context.new(request)
    context.params["p1"].should eq("666")
    context.params["p2"].should eq("aaa")
    context.params["p3"].should eq("hugo")
    context.params["p4"].should eq("abonizio")
  end
end
