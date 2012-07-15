require "date"

module Writer
  class FileNamer
    class << self
      def name_for(filename)
        filename ||= default_filename

        name   = fix_standard(filename)
        name ||= fix_no_ext(filename)
        name ||= prevent_overwrite(filename)

        name
      end

      def fix_standard(name)
        if /.+\..+/ =~ name
          parts = name.split('.')
          basename = parts[0..-2].join('.')
          extension = parts.last

          prevent_overwrite(name, basename, extension)
        end
      end

      def fix_no_ext(name)
        if /\.$/ =~ name
          basename = name.gsub('.', '')

          prevent_overwrite(name, basename)
        end
      end

      def prevent_overwrite(name, base = nil, ext = nil)
        separator = separator_for(name, base)
        to_fix = base || name
        count = 1

        while File.exists?(name)
          name = append_count(to_fix, separator, count += 1)
          name << ".#{ext}" if base
        end

        name
      end

      def default_filename
        date = Date.today
        date.strftime('%Y-%m%b-%d.md')
      end

      def separator_for(name, base = nil)
        return "." if base || name.include?('.')
        "--"
      end

      private
      def append_count(name, separator, count)
        basename = name.gsub(/(--|\.)\d*$/, '')
        zero_pad = count < 10 ? 0 : nil

        [basename, separator, zero_pad, count].join
      end
    end
  end
end
