# libraries/util.rb

module Exhibitor
  module Util
    def should_install_gradle?
      !Dir.exist?(File.join(Chef::Config[:file_cache_path],
                            "gradle-#{node[:gradle][:version]}"))
    end

    def should_install_exhibitor?(jar_dest)
      !File.exist?(jar_dest)
    end

    def render_properties_file(config = {})
      config.sort_by { |k, _v| k }.collect do |k, v|
        "#{k.gsub('_', '-')}=#{v}"
      end.join("\n")
    end

    def render_s3_credentials(config)
      config.sort_by { |k, _v| k }.collect do |name, val|
        "com.netflix.exhibitor.s3.#{name.gsub('_', '-')}=#{val}"
      end.join("\n")
    end

    def format_cli_options(opts)
      opts.sort_by { |k, _v| k }.collect do |opt, val|
        "--#{opt} #{val}"
      end.join(' ')
    end
  end
end
