require "date"
require "writer/configuration"
require "writer/version"

module Writer
  class << self
    def write!(filename = todays_date_md)
      create_file(filename)
    end

    def configure
      @config = Configuration.new
      yield(@config)
    end

    private
    def create_file(name)
      File.open(name, 'w') do |f|
        f.puts template
      end
    end

    def todays_date_md
      date = Date.today
      date.strftime('%Y-%m%b-%d.md')
    end

    def template
      if config.template_path
        File.open(config.template_path).read
      end
    end

    def config
      @config ||= Configuration.new
    end
  end
end
