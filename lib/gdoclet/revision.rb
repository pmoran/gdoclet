module GDoclet

  class Revision < Document

    def title
      @doc.at_xpath('xmlns:title').text
    end
    
    def content_link
      @doc.at_xpath('xmlns:content')['src']
    end

  end

end
