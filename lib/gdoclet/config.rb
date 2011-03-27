require 'singleton'

module GDoclet

  class Config

    include Singleton

    class << self

      def [](key)
        GDoclet::Config.instance[key]
      end

    end

    def [](key)
      config[key]
    end

    private

      def config
        @config ||= load_config
      end

      def load_config
        config_file = File.expand_path(File.join("config", "gdoclet.yaml"))
        puts "****loading config from #{config_file}"
        config = YAML.load_file(config_file)
        config["oauth"] = load_oauth
        config
      end

      def load_oauth
        oauth_file = File.expand_path(File.join("config", "oauth.yaml"))
        if File.exists?(oauth_file)
          puts "****loading oauth from #{oauth_file}"
          YAML.load_file(oauth_file)
        else
          oauth = {}
          %w(consumer_key consumer_secret admin_userid).each { |key| oauth[key] = ENV[key.upcase] if ENV[key.upcase] }
          raise "#{self.class} Couldn't load oauth configuration" if oauth.empty?
          oauth
        end
      end

  end

end
