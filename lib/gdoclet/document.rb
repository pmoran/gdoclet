module GDoclet

  class Document

    attr_reader :doc

    def initialize(xml)
      @doc = xml.kind_of?(String) ? Nokogiri::XML(xml) : xml
    end

    def xml
      @doc.to_s
    end

  end

end
