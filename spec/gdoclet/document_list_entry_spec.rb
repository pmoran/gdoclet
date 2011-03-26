require 'spec_helper'

describe GDoclet::DocumentListEntry do

  before(:each) do
    xml = File.read("spec/fixtures/document.xml")
    @document = GDoclet::DocumentListEntry.new(xml)
  end

  it "should provide a title" do
    @document.title.should == "Document's Title"
  end

  it "should provide a resource id" do
    @document.resource_id.should == "document:12345"
  end

  it "should provide an untyped resource id" do
    @document.untyped_resource_id.should == "12345"
  end

  it "should provide an edit link" do
    @document.edit_link.should == "https://docs.google.com/Doc?docid=12345&hl=en"
  end

  it "should provide a content link" do
    @document.content_link.should == "https://docs.google.com/feeds/download/documents/Export?docId=12345"
  end

  it "should have an entry" do
    @document.has_entry?.should be_true
  end

  it "should have a revisions link" do
    @document.revisions_link.should == "https://docs.google.com/feeds/default/private/full/document%3A12345/revisions"
  end

  it "should not have an entry when no entry element found" do
    xml = File.read("spec/fixtures/missing_document.xml")
    GDoclet::DocumentListEntry.new(xml).has_entry?.should be_false
  end

  context "fixing newlines" do

    it "should handle a nil string" do
      GDoclet::DocumentListEntry.fix_newlines("").should == ""
    end
    
    it "should handle an empty string" do
      GDoclet::DocumentListEntry.fix_newlines("").should == ""
    end
    
    it "should insert a extra new line for each line" do
      GDoclet::DocumentListEntry.fix_newlines("foo\nbar").should == "\n\nbar"
    end

    it "should ignore the first line" do
      GDoclet::DocumentListEntry.fix_newlines("foo").should == ""
    end

    it "should not insert an extra newline for table syntax lines (i.e. '|')" do
      GDoclet::DocumentListEntry.fix_newlines("foo\n|a cell|").should == "\n|a cell|"
    end
    
    it "should convert dos-style carriage returns" do
      GDoclet::DocumentListEntry.fix_newlines("foo\r\nbar").should == "\n\nbar"
    end

  end

end
