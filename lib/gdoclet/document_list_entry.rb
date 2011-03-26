require 'nokogiri'

module GDoclet

  class DocumentListEntry < Document

    def title
      doc.at_xpath("//xmlns:entry/xmlns:title").text
    end

    def resource_id
      doc.at_xpath("//xmlns:entry/gd:resourceId").text
    end

    def untyped_resource_id
      resource_id.split(":").last
    end

    def edit_link
      doc.at_xpath("//xmlns:entry/xmlns:link[@rel='alternate']")['href']
    end

    def revisions_link
      doc.at_xpath("//xmlns:entry/gd:feedLink[@rel='http://schemas.google.com/docs/2007/revisions']")['href']
    end

    def content_link
      doc.at_xpath("//xmlns:entry/xmlns:content")['src']
    end

    def has_entry?
      doc.at_xpath("//xmlns:entry") ? true : false
    end

    def self.fix_newlines(text)
      # nasty hacks to avoid BOM and google docs stripping empty lines
      return "" if text.nil? or text == ""
      output = ""
      text.encode!(universal_newline: true).split(/\n/)[1..-1].each do |line|
        line =~ /^\|/ ? output << "\n" : output << "\n\n"
        output << line
      end
      output
    end

  end

end
