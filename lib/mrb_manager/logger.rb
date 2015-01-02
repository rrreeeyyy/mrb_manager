require 'mrb_manager'
require 'logger'
require 'ansi/code'

module MrbManager
  module Logger
    class Formatter
      attr_accessor :colored
      def call(level, _datetime, _progname, msg)
        log = format("%s : %s\n", format('%5s', level), msg_to_str(msg))
        colored ? coloring(log, level) : log
      end

      private

      def msg_to_str(msg)
        case msg
        when ::String
          msg
        when ::Exception
          "#{ msg.message } (#{ msg.class })\n" <<
            (msg.backtrace || []).join("\n")
        else
          msg.inspect
        end
      end

      def coloring(str, level)
        code = case level
               when 'INFO'
                 :green
               when 'WARN'
                 :yellow
               when 'ERROR'
                 :red
               else
                 :clear
               end
        ANSI.public_send(code) { str }
      end
    end

    class << self
      def logger
        @logger ||= create_logger
      end

      def log_device
        @log_device || $stdout
      end

      def log_device=(value)
        @log_device = value
        @logger = create_logger
      end

      private

      def create_logger
        ::Logger.new(log_device).tap do |logger|
          logger.formatter = Formatter.new
        end
      end

      def respond_to_missing?(method)
        logger.respond_to?(method)
      end

      def method_missing(method, *args, &block)
        logger.public_send(method, *args, &block)
      end
    end
  end
end
