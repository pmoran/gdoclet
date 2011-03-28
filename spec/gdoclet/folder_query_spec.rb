require 'spec_helper'

describe GDoclet::FolderQuery do
  
  before(:each) do
    session = GDoclet::Session.login(debug: true)
    @query = session.folder_query
    @folder_feed = File.read("spec/fixtures/folder_feed.xml")
  end

  context "#contents" do

    it "should return a folder's as a xml" do
      fake_get("/feeds/default/private/full/folder:12345/contents?xoauth_requestor_id=admin@example.com", @folder_feed)
      @query.contents("folder:12345").should == @folder_feed
    end

  end
  
  context "#by_title" do

    it "should return a folder as a document list entry" do
      fake_get("/feeds/default/private/full?showfolders=true&title=folder title&title-exact=true&category=folder&xoauth_requestor_id=admin@example.com", @folder_feed)
      folder = @query.by_title("folder title")
      folder.should be_a_kind_of(GDoclet::DocumentListEntry)
    end

  end
  
  
end