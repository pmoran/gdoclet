require 'spec_helper'
require 'fakeweb'

describe GDoclet::DocumentQuery do

  before(:each) do
    GDoclet::Config.instance.stub!("load_oauth").and_return({})
    session = GDoclet::Session.login(debug: true)
    @query = session.document_query
  end

  context "#by_title" do

    it "should return a document" do
      url = URI.escape("https://docs.google.com/feeds/default/private/full?title=Document's Title&title-exact=true&xoauth_requestor_id=")
      FakeWeb.register_uri(:get, url, :body => File.read("spec/fixtures/document.xml"))
      document = @query.by_title("Document's Title")
      document.should be_a_kind_of(GDoclet::DocumentListEntry)
      document.title.should == "Document's Title"
    end

  end

  context "#by_id" do

    it "should return a document" do
      url = URI.escape("https://docs.google.com/feeds/default/private/full/document:12345?xoauth_requestor_id=")
      FakeWeb.register_uri(:get, url, :body => File.read("spec/fixtures/document.xml"))
      document = @query.by_id("document:12345")
      document.should be_a_kind_of(GDoclet::DocumentListEntry)
      document.resource_id.should == "document:12345"
    end

    it "should error if no id provided" do
      lambda {document = @query.by_id(nil)}.should raise_error(GDoclet::ApiError)
    end

    it "should error if empty id provided" do
      lambda {document = @query.by_id("")}.should raise_error(GDoclet::ApiError)
    end

  end

end
