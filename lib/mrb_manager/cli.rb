require 'mrb_manager'
require 'thor'

module MrbManager
  class CLI < Thor
    class_option :log_level, type: :string, default: 'info'
    class_option :color, type: :boolean, default: true

    def initialize(*args)
      super
      MrbManager::Logger.level = ::Logger.const_get(options[:log_level].upcase)
      MrbManager::Logger.formatter.colored = options[:color]
    end

    desc 'install VERSION [options...]', 'Install mruby with active mgems'
    option :tag, type: :string, aliases: ['-t']
    option :version, type: :string, aliases: ['-v']
    option :build_config, type: :string
    option :src_dir, type: :string
    option :sha, type: :string
    def install(version = nil)
      unless options[:src_dir] || options[:sha] || version
        Logger.error 'VERSION, --src-dir or --sha is required'
        abort
      end
      MrbManager::Installer.install(version, options)
    end

    desc 'uninstall (TAG|ID)', 'Uninstall mruby binary specified TAG or ID'
    def uninstall(identifier)
      MrbManager::Uninstaller.uninstall(identifier)
    end

    desc 'versions', 'List all available mruby versions'
    def versions
      MrbManager::Manager.output_versions
    end

    desc 'list', 'List all installed mruby versions'
    def list
      # MrbManager::Binaries.list
    end

    desc 'init', 'Output PATH and Shell settings'
    def init
      # Manager.init
    end
  end
end
