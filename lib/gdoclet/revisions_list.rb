module GDoclet

  class RevisionsList < Document

    def revisions
      @doc.xpath("//xmlns:entry").map do |e|
        GDoclet::Revision.new(e)
      end
    end

    def published
      xml = @doc.at_xpath("//xmlns:entry[docs:publish/@value='true']")
      xml ? GDoclet::Revision.new(xml) : nil
    end

  end

end
