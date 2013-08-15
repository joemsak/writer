module Writer
  autoload :Version,       "writer/version"
  autoload :FileNamer,     "writer/file_namer"
  autoload :FileCreator,   "writer/file_creator"
  autoload :Logger,        "writer/logger"
  autoload :Configuration, "writer/configuration"

  class << self
    def write!(name = nil, content = nil)
      name = file_namer.name_for(name)

      logger.info "Creating #{name}"

      file_creator.create!(name, content)
    end

    def file_namer
      @file_namer ||= namer.new
    end

    def file_creator
      @file_creator ||= creator.new
    end

    def logger
      @logger ||= config.logger.new
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

def wr(*args)
  `wr #{args.join(' ')}`
end
