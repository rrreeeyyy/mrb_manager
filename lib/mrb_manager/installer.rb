require 'mrb_manager'
require 'zip'
require 'open-uri'

module MrbManager
  class Installer
    class << self
      def install(version, options)
        case
        when version
          install_from_url(version, options)
        when options[:src_dir]
          install_from_src(options)
        when options[:sha]
          install_from_sha(options)
        end
      end

      private

      def install_from_url(version, options)
        Dir.mktmpdir('mrbm') do |tmpdir|
          url = Manager.zipball_url(version)
          Logger.info "Download mruby from #{url} ..."
          zip = Zip::File.open(open(url))
          extract_zip(zip, tmpdir)
          workdir = File.join(tmpdir, zip.first.name)
          minirake(workdir, options)
          Binary.create(workdir, options)
        end
      end

      def install_from_src(options)
        workdir = options[:src_dir]
        Logger.info "Install mruby from #{workdir} ..."
        unless FileTest.directory?(workdir)
          Logger.error "#{workdir} doesn't exist."
          abort
        end
        minirake(workdir, options)
        Binary.create(workdir, options)
      end

      def extract_zip(zip, dest)
        zip.each do |entry|
          entry.extract(File.join(dest, entry.to_s))
        end
      end

      def minirake(workdir, options)
        overwrite_build_config(workdir, options)
        Logger.info "`MRUBY_CONFIG='' /usr/bin/env ruby minirake` in #{workdir}"
        Dir.chdir(workdir) do
          unless FileTest.exist?('./minirake')
            Logger.error "#{File.join(workdir, minirake)} doesn't exist."
            abort
          end
          system('MRUBY_CONFIG='' /usr/bin/env ruby minirake')
        end
      end

      def overwrite_build_config(workdir, options)
        Logger.info "Search --build_config or ENV['MRUBY_CONFIG']"
        config = if options[:build_config]
                   options[:build_config]
                 elsif ENV['MRUBY_CONFIG']
                   ENV['MRUBY_CONFIG']
                 end
        if config && FileTest.exist?(config)
          Logger.info "Overwrite #{File.join(workdir, 'build_config.rb')} with the #{config}"
        else
          return Logger.warn "#{config} doesn't exist. Using default 'build_config.rb'"
        end
        FileUtils.cp(config, File.join(workdir, 'build_config.rb'), preserve: true)
      end
    end
  end
end
