# libraries/util.rb

module Exhibitor
  module Util
    def render_s3_credentials(config)
      config.sort_by { |k, _v| k }.collect do |name, val|
        "com.netflix.exhibitor.s3.#{name.tr('_', '-')}=#{val}"
      end.join "\n"
    end
  end
end
