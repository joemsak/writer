module Writer
  class FileCreator
    class << self
      def create!(filename, content = nil)
        create_file(filename, content)
        File.open(filename, 'r')
      end

      private
      def create_file(name, content)
        File.open(name, 'w') do |f|
          f.puts content || template
        end
      end

      def template
        if Writer.template_path
          File.open(Writer.template_path).read
        end
      end
    end
  end
end
