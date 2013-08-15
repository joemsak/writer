module Writer
  class Logger
    def info(*args)
      return if log_level < 2

      out = if args.many?
              o = ["#{args.pop}:"]
              args.each { |a| o << a }
            else
              [args]
            end

      $stdout.print(out.join(' ') + "\n")
    end

    class << self
      def config
        @config ||= Writer.config
      end
    end

    private
    #log_level
    #
    # 0 - error
    # 1 - warn
    # 2 - info
    # 3 - debug
    def log_level
      self.class.config.log_level
    end
  end
end
