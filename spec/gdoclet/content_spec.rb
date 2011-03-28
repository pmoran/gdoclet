require 'spec_helper'

describe GDoclet::Content do

  context "#for" do

    context "missing content" do

      it "should return error html when no document retrieved" do
        fake_get("/feeds/default/private/full/document:12345?xoauth_requestor_id=admin@example.com", File.read("spec/fixtures/missing_document.xml"))
        GDoclet::Content.for(:id => "document:12345").should =~ /Content missing/
      end

      it "should return error html when no published document retrieved" do
        fake_get("/feeds/default/private/full/document:12345?xoauth_requestor_id=admin@example.com", File.read("spec/fixtures/document.xml"))
        fake_get("/feeds/default/private/full/document:12345/revisions?xoauth_requestor_id=admin@example.com", File.read("spec/fixtures/revisions_unpublished.xml"))
        GDoclet::Content.for(:id => "document:12345").should =~ /Published content missing/
      end

    end

    context "published content" do

      it "should provide some html for a published document" do
        fake_get("/feeds/default/private/full/document:12345?xoauth_requestor_id=admin@example.com", File.read("spec/fixtures/document.xml"))
        fake_get("/feeds/default/private/full/document:12345/revisions?xoauth_requestor_id=admin@example.com", File.read("spec/fixtures/revisions_published.xml"))
        fake_get("/feeds/download/documents/Export?docId=doc_id&revision=2&exportFormat=txt&format=txt&xoauth_requestor_id=admin@example.com", "==\nh1. My Title")
        GDoclet::Content.for(:id => "document:12345").should == "<h1>My Title</h1>"
      end

    end

  end

end
