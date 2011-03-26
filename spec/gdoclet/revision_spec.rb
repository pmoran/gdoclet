require 'spec_helper'

describe GDoclet::Revision do
  
  it "should have a title" do
    xml = Nokogiri::XML(File.read("spec/fixtures/document.xml"))
    entry = GDoclet::Revision.new(xml.at_xpath("//xmlns:entry"))
    entry.title.should == "Document's Title"
  end
  
end