require "date"
require "writer/configuration"
require "writer/version"

module Writer
  class << self
    def write!(name = default_filename, content = nil)
      protect_from_overwrite(name)
      create_file(content)
      File.open(filename, 'r')
    end

    def configure
      @config = Configuration.new
      yield(@config)
    end

    private
    def protect_from_overwrite(name)
      count = 1
      while File.exists?(name)
        name = append_count(name, count += 1)
      end
      @filename = name
    end

    def create_file(content = nil)
      File.open(filename, 'w') do |f|
        f.puts content || template
      end
    end

    def append_count(name, count)
      if (split = name.split('.')).length > 1
        ext = split.last
        split.delete(ext)
        name = split.join
      end

      name = name.gsub(/--\d$/,'')

      [name + "--#{count}", '.', ext].join
    end

    def default_filename
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

    def filename
      @filename
    end
  end
end
