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
        oauth_file = File.expand_path(File.join("config", "oauth.yaml"))
        if File.exists?(oauth_file)
          puts "****loading oauth from #{oauth_file}"
          config["oauth"] = YAML.load_file(oauth_file)
        end
        config
      end

  end

end
