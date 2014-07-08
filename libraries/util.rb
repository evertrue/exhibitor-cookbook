# libraries/util.rb

module Exhibitor
  module Util
    def should_install_gradle?
      return !Dir.exists?(File.join(Chef::Config[:file_cache_path], 'gradle'))
    end

    def should_install_exhibitor?(jar_dest)
      return !File.exists?(jar_dest)
    end

    def render_properties_file(config={})
      config.sort_by {|k,v| k}.collect do |k, v|
        "#{k.gsub('_', '-')}=#{v}"
      end.join("\n")
    end

    def render_s3_credentials(config)
      config.sort_by {|k,v| k}.collect do |name, val|
        "com.netflix.exhibitor.s3.#{name.gsub('_', '-')}=#{val}"
      end.join("\n")
    end

    def format_cli_options(opts)
      opts.sort_by {|k,v| k}.collect do |opt, val|
        "--#{opt.to_s} #{val.to_s}"
      end.join(' ')
    end
  end
end
