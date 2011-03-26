require 'spec_helper'

describe GDoclet::RevisionsList do
  
  it "should provide the published entry" do
    revisions_list = GDoclet::RevisionsList.new(File.read("spec/fixtures/revisions_published.xml"))
    revisions_list.published.title.should == "Revision 2"
  end
  
  it "should return nil when no entries are published" do
    revisions_list = GDoclet::RevisionsList.new(File.read("spec/fixtures/revisions_unpublished.xml"))
    revisions_list.published.should be_nil
  end
  
  context "#revisions" do
    
        
    it "should provide a revision for each entry" do
      revisions_list = GDoclet::RevisionsList.new(File.read("spec/fixtures/revisions_published.xml"))
      revisions = revisions_list.revisions
      revisions.should have(3).entries
      revisions.first.title.should == "Revision 0"
      revisions.last.title.should == "Revision 2"
    end
    
  end
  
end