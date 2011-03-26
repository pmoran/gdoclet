module GDoclet

  class DocumentQuery < Query

    # Returns first document matching title
    def by_title(title)
      check(title)
      document_for("/feeds/default/private/full?title=#{title}&title-exact=true")
    end

    def by_id(resource_id)
      check(resource_id)
      document_for("/feeds/default/private/full/#{resource_id}")
    end

    def download(content_link, format = "txt")
      successfully_get("#{content_link}&exportFormat=#{format}&format=#{format}") do |get|
        DocumentListEntry.fix_newlines(get.body)
      end
    end
    
    def published_content_for(doc)
      list = session.revisions_query.by_id(doc.resource_id)
      return unless list
      doc = list.published
      doc ? download(doc.content_link) : nil
    end

    private

      def document_for(feed)
        successfully_get(feed) do |get|
          doc = GDoclet::DocumentListEntry.new(get.body)
          doc.has_entry? ? doc : nil
        end
      end

  end

end
