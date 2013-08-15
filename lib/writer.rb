require "writer/configuration"
require "writer/version"

module Writer
  class << self
    def write!(name = nil, content = nil)
      name = namer.name_for(name)
      creator.create!(name, content)
    end

    def configure
      yield(config)
    end

    # attempt delegation to config
    def method_missing(name, *args)
      config.send(name, *args)
    end

    def configure
      yield(config)
    end

    def config
      @config ||= Configuration.new
    end

    def set_default_config!
      @config = Configuration.new
    end

    def method_missing(method_name, *args)
      attrs = config.attributes.keys
      return super unless attrs.include?(method_name)

      config.send(method_name, *args)
    end
  end
end

require "writer/file_creator"

def wr(*args)
  `wr #{args.join(' ')}`
end
