require "active_support/all"

module Writer
  class Configuration
    attr_accessor :template_path, :date_format, :namer, :creator

    def initialize
      @namer   ||= 'Writer::FileNamer'
      @creator ||= 'Writer::FileCreator'
    end

    def namer
      const(@namer)
    end

    def creator
      const(@creator)
    end

    private
    def const(name)
      if (parts = name.to_s.split('_')).size > 1
        parts.collect(&:capitalize).join.constantize
      else
        name.constantize
      end
    end
  end
end
