module Writer
  class OverwritePrevention
    class << self
      def adjust(filename)
        name = fix_standard(filename)
        name ||= fix_no_extension(filename)
        name ||= fix_no_base(filename)
        name ||= fix_no_dots(filename)
        name
      end

      def fix_standard(name)
        if /.+\..+/ =~ name
          parts = name.split('.')
          basename = parts[0..-2].join('.')
          extension = parts.last

          fix_name(name, basename, extension)
        end
      end

      def fix_no_extension(name)
        if /\.$/ =~ name
          basename = name.gsub('.', '')

          fix_name(name, basename)
        end
      end

      def fix_no_base(name)
        if /^\./ =~ name
          fix_name(name)
        end
      end

      def fix_no_dots(name)
        unless name.include?('.')
          fix_name(name)
        end
      end

      private
      def fix_name(name, base = nil, ext = nil)
        to_fix = base || name
        count = 1

        while File.exists?(name)
          name = append_count(to_fix, count += 1)
          name << ".#{ext}" if base
        end

        name
      end

      def append_count(name, count)
        name = name.gsub(/--\d*$/, '')
        [name, "--", count].join
      end
    end
  end
end
