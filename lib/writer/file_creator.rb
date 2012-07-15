require "writer/overwrite_prevention"

module Writer
  class FileCreator
    class << self
      attr_accessor :name, :content

      def create!(name, content)
        @name = OverwritePrevention.adjust(name)
        @content = content

        create_file
        return file
      end

      private
      def create_file
        File.open(name, 'w') do |f|
          f.puts content || template
        end
      end

      def template
        if Writer.template_path
          File.open(Writer.template_path).read
        end
      end

      def file
        File.open(name, 'r')
      end
    end
  end
end
