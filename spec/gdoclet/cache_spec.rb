require 'spec_helper'

describe GDoclet::Cache do

  it "should set and get some content" do
    GDoclet::Cache.instance.set(123, "foo")
    GDoclet::Cache.instance.get(123).should == "foo"
  end

  it "should allow class level access" do
    GDoclet::Cache.set(123, "foo")
    GDoclet::Cache.get(123).should == "foo"
  end

  context "#flush" do

    it "should return false for an invalid token" do
      GDoclet::Cache.instance.stub!("flush_token").and_return("valid token")
      GDoclet::Cache.flush("token").should be_false
    end
    
    it "should return false for an invalid token" do
      GDoclet::Cache.instance.stub!("flush_token").and_return("valid token")
      GDoclet::Cache.flush("valid token").should be_true
    end

    it "can be flushed" do
      GDoclet::Cache.instance.stub!("flush_token").and_return("valid token")
      GDoclet::Cache.instance.set(123, "foo")
      GDoclet::Cache.flush("valid token")
      GDoclet::Cache.get(123).should be_nil
    end

  end

end
