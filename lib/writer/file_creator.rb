module Writer
  class FileCreator
    def create!(filename, content = nil)
      create_file(filename, content)
      File.open(filename, 'r')
    end

    private
    def create_file(name, content)
      File.open(name, 'w') do |f|
        case content
        when /[A-Z]+=\w+/
          f.puts template_with_variables(content)
        when nil
          f.puts template
        else
          f.puts content
        end
      end
    end

    def template
      unless Writer.template_path.blank?
        @template ||= File.open(Writer.template_path).read
      end
    end

    def template_with_variables(content)
      return content if template.nil?
      modified_template = template

      content.split(' ').each do |k_v|
        key = k_v.split('=')[0].downcase
        value = k_v.split('=')[1]
        puts key
        puts value
        modified_template.gsub!(/%{#{key}}/, value)
      end

      modified_template
    end
  end
end
