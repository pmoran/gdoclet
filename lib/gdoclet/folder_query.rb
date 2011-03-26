module GDoclet

  class FolderQuery < Query

    def all
      successfully_get("/feeds/default/private/full?showfolders=true&category=folder") do |get|
        get.body
      end
    end

    def by_title(title)
      check(title)
      successfully_get("/feeds/default/private/full?showfolders=true&title=#{title}&title-exact=true&category=folder") do |get|
        GDoclet::DocumentListEntry.new(get.body)
      end
    end

    def contents(id)
      check(id)
      successfully_get("/feeds/default/private/full/#{id}/contents") do |get|
        get.body
      end
    end

  end

end
