module GDoclet

  class RevisionsQuery < Query

    def by_id(resource_id)
      successfully_get("/feeds/default/private/full/#{resource_id}/revisions") do |get|
        GDoclet::RevisionsList.new(get.body)
      end
    end

  end

end
