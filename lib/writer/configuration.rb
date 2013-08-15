require "active_support/all"

module Writer
  class Configuration
    attr_accessor :template_path, :date_format, :attributes,
      :log_level, :logger, :namer, :creator

    def initialize(attrs = {})
      attrs = attrs.merge(config)

      attrs.each do |attr, value|
        self.send("#{attr}=", value)
      end

      @attributes = attrs
    end

    def namer=(other)
      @namer = Object.const_get(other)
    end

    def logger=(other)
      @logger = Object.const_get(other)
    end

    def creator=(other)
      @creator = Object.const_get(other)
    end

    private
    def config
      conf = default_config
      path = 'config/writer.yml'

      if File.exist?(path)
        config_file = File.open(path)
        user_config = YAML.load(config_file)

        conf = conf.merge(user_config)
      end

      conf
    end

    def default_config
      {
        namer:         'Writer::FileNamer',
        creator:       'Writer::FileCreator',
        logger:        'Writer::Logger',
        date_format:   '%Y-%m%b-%d',
        log_level:     2, # see Logger for levels
        template_path: ''
      }
    end
  end
end
