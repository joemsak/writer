require "date"
require "writer/configuration"
require "writer/version"
require "writer/file_creator"

module Writer
  class << self
    def write!(name = nil, content = nil)
      name ||= default_filename
      FileCreator.create!(name, content)
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
    def default_filename
      date = Date.today
      date.strftime('%Y-%m%b-%d.md')
    end

    def config
      @config ||= Configuration.new
    end
  end
end

def wr(*args)
  `wr #{args.join(' ')}`
end
