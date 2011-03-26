module GDoclet

  class Query

    attr_reader :session

    def initialize(session)
      @session = session
    end

    private

      def successfully_get(feed)
        get = session.get(feed)
        raise GDoclet::ApiError.new("#{get.code} #{get.class}") unless get.code.to_i == 200
        yield get
      end

      def check(value)
        bad = value.is_a?(String) ? value.empty? : value.nil?
        raise GDoclet::ApiError.new("#{self.class} Missing query term") if bad
      end

  end

end
