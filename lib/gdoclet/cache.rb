require 'dalli'
require 'singleton'

module GDoclet

  class InMemoryCache

    HEAP = {}

    def set(key, value)
      HEAP[key] = value
    end

    def get(key)
      HEAP[key]
    end

    def flush
      HEAP.clear
      true
    end

  end

  class Cache

    include Singleton

    class << self

      ["enabled?", "set", "get", "flush"].each do |method|
        define_method(method) { |*args| GDoclet::Cache.instance.send(method, *args) }
      end

    end

    def get(key)
      safely do
        cached_content = cache.get(key)
        log("#{self.class} hit: #{key}") if cached_content
        cached_content
      end
    end

    def set(key, html)
      safely { cache.set(key, html) }
    end

    def flush(token)
      return false unless token_valid?(token)
      safely { cache.flush }
    end

    def enabled?
      Config["cache"]["enabled"]
    end

    private

      def log(msg)
        puts msg if Config["debug"]
      end
      
      def cache
        @cache ||= init_cache
      end

      def init_cache
        return InMemoryCache.new if Config["cache"]["store"] == "memory"
        expires_in = Config["cache"]["expires_in"] || 300
        Dalli::Client.new("localhost:11211", :expires_in => expires_in)
      end

      def token_valid?(input_token)
        input_token && !input_token.empty? && input_token == flush_token
      end

      def flush_token
        session = Session.login
        query = session.document_query
        doc = query.by_id(Config["cache"]["flush_resource_id"])
        query.download(doc.content_link).strip
      end

      def safely
        begin
          yield
        rescue => e
          puts "#{self.class} error: #{e}"
        end
      end

  end

end
