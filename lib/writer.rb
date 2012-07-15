require "date"
require "writer/configuration"
require "writer/version"
require "writer/overwrite_prevention"

module Writer
  class << self
    def write!(name = nil, content = nil)
      name = default_filename if name.nil?
      filename = OverwritePrevention.adjust_name(name)

      create_file(filename, content)
      File.open(filename, 'r')
    end

    def configure
      yield(config)
    end

    private
    def create_file(filename, content = nil)
      File.open(filename, 'w') do |f|
        f.puts content || template
      end
    end

    def template
      if config.template_path
        File.open(config.template_path).read
      end
    end

    def default_filename
      date = Date.today
      date.strftime('%Y-%m%b-%d.md')
    end

    def config
      @config ||= Configuration.new
    end
  end
end
