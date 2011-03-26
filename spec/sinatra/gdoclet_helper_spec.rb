require 'spec_helper'
require 'sinatra/base'

describe Sinatra::GDocletHelper do
  
  include Sinatra::GDocletHelper
  
  context "#content" do
    
    it "should return the gdoclet content" do
      options = {foo: "foo"}
      GDoclet::Content.should_receive("for").with(options).and_return("some html")
      content(options).should == "some html"
    end
    
  end
  
  context "#edit_link" do
    
    it "should return a link to the gdoclet edit url" do
      options = {foo: "foo"}
      GDoclet::Content.should_receive("edit_link_for").with(options).and_return("http://some.url")
      edit_link(options).should == "<a class='edit' href='http://some.url' target='_blank'>Edit</a>"
    end
    
  end
  
  context "#flush_content" do

    it "should flush the gdoclet cache when successfull" do
      now = Time.now
      Time.stub!("now") {now}
      GDoclet::Cache.should_receive("flush").with("a token").and_return(true)
      flush_content("a token").should ==  "Cached content flushed at #{now}"
    end
    
    it "should return forbidden when unsuccessfull" do
      should_receive("status").with(403)
      GDoclet::Cache.stub!("flush").and_return(false)
      flush_content("a token").should == "Forbidden"
    end
    
  end
  
end