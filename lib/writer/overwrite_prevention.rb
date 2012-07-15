module Writer
  class OverwritePrevention
    def self.adjust_name(name)
      count = 1

      while File.exists?(name)
        name = append_count(name, count +=1)
      end

      name
    end

    def self.append_count(name, count)
      if (split = name.split('.')).length > 1
        ext = split.last
        split.delete(ext)
        name = split.join
      end

      name = name.gsub(/--\d$/,'')

      [name + "--#{count}", '.', ext].join
    end
  end
end
