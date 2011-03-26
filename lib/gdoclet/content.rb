require 'redcloth'

module GDoclet

  class Content

    class << self

      def for(options = {})
        begin
          with_caching(options[:id]) do
            query = document_query(options)
            doc = query.by_id(options[:id]) || raise(GDoclet::ApiError.new("Content missing"))
            content = query.published_content_for(doc) || raise(GDoclet::ApiError.new("Published content missing"))
            html(content, doc, options)
          end
        rescue GDoclet::ApiError => e
          error(e.message, options[:id])
        end
      end

      def with_caching(key)
        html = Cache.get(key) if Cache.enabled?
        return html if html
        html = yield
        Cache.set(key, html) if Cache.enabled?
        html
      end

      def edit_link_for(options = {})
        document_query(options).by_id(options[:id]).edit_link
      end

      def edit_link(doc)
        "<div class='edit'><a href='#{doc.edit_link}' target='_blank'>Edit</a></div>"
      end

      def error(msg, id)
        puts "****#{self.name} id #{id}: #{msg}"
        "<div class='error'><em>#{msg}</em></div>"
      end

      def document_query(options)
        session = GDoclet::Session.login(options.merge(debug: Config["debug"]))
        session.document_query
      end

      def html(content, doc, options)
        html = RedCloth.new(content).to_html
        html << edit_link(doc) if options[:edit_link]
        html
      end

    end

    private_class_method :document_query, :html, :with_caching

  end

end
