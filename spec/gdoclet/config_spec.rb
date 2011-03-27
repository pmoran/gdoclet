require 'spec_helper'

describe GDoclet::Config do

  before(:each) do
    GDoclet::Config.instance.stub!("load_oauth").and_return({})
  end

  it "should be a singleton" do
    GDoclet::Config.instance.should == GDoclet::Config.instance
  end

  context "#[]" do

    it "returns the value for a key" do
      GDoclet::Config.instance["debug"].should be_true
    end

    it "allows class-level access" do
      GDoclet::Config["debug"].should be_true
    end

  end

end
