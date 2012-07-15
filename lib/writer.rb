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
      return config.send(name, *args)
      rescue
        super
    end

    private
    def config
      @config ||= Configuration.new
    end
  end
end

def wr(*args)
  `wr #{args.join(' ')}`
end
