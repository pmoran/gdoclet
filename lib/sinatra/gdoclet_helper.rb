require 'sinatra/base'
require 'gdoclet'

module Sinatra

  module GDocletHelper

    def content(options = {})
      GDoclet::Content.for(options)
    end

    def edit_link(options = {})
      link = GDoclet::Content.edit_link_for(options)
      "<a class='edit' href='#{link}' target='_blank'>Edit</a>"
    end

    def flush_content(token)
      if GDoclet::Cache.flush(token)
        "Cached content flushed at #{Time.now}"
      else
        status 403
        "Forbidden"
      end
    end

  end

  helpers GDocletHelper

end
