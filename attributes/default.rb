# attributes/default.rb

default['java']['jdk_version'] = '7'

# Set Zookeeper to use Exhibitor as its service manager
default['zookeeper']['service_style'] = 'exhibitor'
default['exhibitor']['service_style'] = 'runit'
default['exhibitor']['service_actions'] = [:enable, :start]

# Gradle specifics for installation
default['et_gradle']['version'] = '2.4'

default['exhibitor']['zookeeper_version'] = node['zookeeper']['version']
default['exhibitor']['version']        = '1.5.5'
default['exhibitor']['user']           = 'zookeeper'
default['exhibitor']['install_method'] = 'gradle' # maven or gradle
default['exhibitor']['loglevel']       = 'info'

default['exhibitor']['install_dir']     = '/opt/exhibitor'
default['exhibitor']['snapshot_dir']    = '/tmp/zookeeper'
default['exhibitor']['transaction_dir'] = '/tmp/zookeeper'
default['exhibitor']['log_index_dir']   = '/tmp/zookeeper_log_indexes'
default['exhibitor']['log_to_syslog']   = '1'

default['exhibitor']['patch_package'] = 'patch'

# Command line arguments
default['exhibitor']['cli'] = {
  'port'          => '8080',
  'hostname'      => node['ipaddress'],
  'configtype'    => 'file',
  'defaultconfig' => File.join(node['exhibitor']['install_dir'], 'exhibitor.properties'),
}

# Example --config S3 values
#   node['exhibitor']['cli']['configtype'] = 's3'
#   node['exhibitor']['s3']['access-key-id'] = 'key'
#   node['exhibitor']['s3']['access-secret-key'] = 'secret'
#   node['exhibitor']['cli']['s3config'] = 'example-bucket:fake/path'
#   node['exhibitor']['cli']['s3region'] = 'us-west-1'

# What gets rendered to node[:exhibitor][:cli][:defaultconfig]
default['exhibitor']['config'] = {
  'cleanup-period-ms'                        => 5 * 60 * 1000,
  'check-ms'                                 => '30000',
  'backup-period-ms'                         => '0',
  'client-port'                              => '2181',
  'cleanup-max-files'                        => '20',
  'backup-max-store-ms'                      => '0',
  'connect-port'                             => '2888',
  'backup-extra'                             => '',
  'observer-threshold'                       => '0',
  'election-port'                            => '3888',
  'zoo-cfg-extra'                            => 'tickTime\=2000&initLimit\=10&syncLimit\=5',
  'auto-manage-instances-settling-period-ms' => '0',
  'auto-manage-instances'                    => '1',
  'servers-spec'                             => "1:#{node['ipaddress']}",
}
