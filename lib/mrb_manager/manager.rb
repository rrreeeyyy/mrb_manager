require 'mrb_manager'
require 'securerandom'
require 'json'
require 'faraday'
require 'mgem'

module MrbManager
  class Manager
    MRBM_HOME = ENV['MRBM_HOME'] ||= ENV['HOME']
    MRBM_DIR = '.mrbm'

    class << self
      def output_versions
        Logger.info 'Available versions:'
        versions.reverse.map { |v| Logger.info "  - #{v}" }
      end

      def zipball_url(version)
        tag = retrive_tags.select { |h| h['name'] == version }
        if tag.empty?
          Logger.error "Version \"#{version}\" not found."
          output_versions
          abort
        else
          tag.first['zipball_url']
        end
      end

      private

      def retrive_tags
        return @tags if @tags
        response = Faraday.new(url: 'https://api.github.com/')
                   .get(File.join(%w(repos mruby mruby tags)))
        @tags = JSON.parse(response.body)
      end

      def versions
        retrive_tags.map { |h| h['name'] }
      end
    end
  end
end
