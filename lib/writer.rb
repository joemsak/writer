require "writer/configuration"
require "writer/version"
require "writer/file_creator"

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

    def config=(other)
      @config = other
    end

    def config
      @config ||= Configuration.new
    end
  end
end

def wr(*args)
  `wr #{args.join(' ')}`
end
