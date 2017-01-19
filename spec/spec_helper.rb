require 'chefspec'
require 'chefspec/berkshelf'

# Generate a report
ChefSpec::Coverage.start!

RSpec.configure do |config|
  config.color     = true
  config.formatter = :documentation
  config.platform  = 'ubuntu'
  config.version   = '16.04'
end
