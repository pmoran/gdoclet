require 'spec_helper'


describe GDoclet::Session do
  
  before(:each) do
    GDoclet::Config.instance.stub!("load_oauth").and_return({})
    @session = GDoclet::Session.login
  end
  
  context "#document_query" do
    
    it "should be provided" do
      @session.document_query.should be_a_kind_of(GDoclet::DocumentQuery)
    end
    
  end
  
  context "#folder_query" do
    
    it "should be provided" do
      @session.folder_query.should be_a_kind_of(GDoclet::FolderQuery)
    end
    
  end

  context "authorise_feed" do
    
    it "should append requestor id" do
      @session.authorise_feed("http://foo.com").should =~ /http:\/\/foo.com\?xoauth_requestor_id=/
    end
    
    it "should append requestor id when other query params exists" do
      @session.authorise_feed("http://foo.com?foo=bar").should =~ /http:\/\/foo.com\?foo=bar&xoauth_requestor_id=/
    end
    
  end
  
end