require 'oauth'

module GDoclet

  class ApiError < StandardError
  end

  VERSION_INFO = {"GData-Version" => "3.0"}

  class Session

    class << self

      def login(options = {})
        oauth = Config["oauth"]
        consumer = OAuth::Consumer.new(oauth["consumer_key"], oauth["consumer_secret"],
                                       :site => "https://docs.google.com",
                                       :request_token_path => "/oauth/request_token",
                                       :authorize_path => "/oauth/authorize",
                                       :access_token_path => "/oauth/access_token",
                                       :http_method => :get )

        # consumer.http.set_debug_output($stderr) if options[:debug]
        new(OAuth::AccessToken.new(consumer), oauth["admin_userid"], options[:debug])
      end

    end

    def initialize(access_token, admin_userid, debug = false)
      @access_token = access_token
      @admin_userid = admin_userid
      @debug = debug
    end

    def folder_query
      FolderQuery.new(self)
    end

    def document_query
      DocumentQuery.new(self)
    end

    def revisions_query
      RevisionsQuery.new(self)
    end

    def get(feed)
      uri = URI.escape(authorise_feed(feed))
      log(uri)
      get = @access_token.get(uri, VERSION_INFO)
      get
    end

    def authorise_feed(feed)
      feed =~ /\?/ ? feed << "&" : feed << "?"
      "#{feed}xoauth_requestor_id=#{@admin_userid}"
    end

    private

      def log(msg)
        puts "****#{self.class} GET #{msg}" if @debug
      end

      def write_out(str)
        File.open("output.xml", 'w') {|f| f.write(str)} if @debug
      end

  end

end
