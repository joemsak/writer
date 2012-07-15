module Writer
  class Configuration
    attr_accessor :template_path, :namer, :creator

    def initialize
      @namer = FileNamer
      @creator = FileCreator
    end
  end
end
