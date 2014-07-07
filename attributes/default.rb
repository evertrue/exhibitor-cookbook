# attributes/default.rb

# Gradle specifics for installation
default[:gradle][:version] = '1.5'
default[:gradle][:checksum] = 'a5511a0659caa47d9d74fd2844c9da43157d2f78e63a0223c6289d88f5aaecbe'

default[:exhibitor][:version]        = '1.5.0'
default[:exhibitor][:user]           = 'zookeeper'
default[:exhibitor][:install_method] = 'build'
default[:exhibitor][:loglevel]       = 'info'

default[:exhibitor][:install_dir]     = '/opt/exhibitor'
default[:exhibitor][:script_dir]      = '/usr/local/bin/'
default[:exhibitor][:snapshot_dir]    = '/tmp/zookeeper'
default[:exhibitor][:transaction_dir] = '/tmp/zookeeper'
default[:exhibitor][:log_index_dir]   = '/tmp/zookeeper_log_indexes'
default[:exhibitor][:log_to_syslog]   = '1'

# Command line arguments
default[:exhibitor][:cli] = {
  port: '8080',
  hostname: node[:ipaddress],
  configtype: 'file',
  defaultconfig: File.join(node[:exhibitor][:install_dir], 'exhibitor.properties')
}

# Example --config S3 values
#   node[:exhibitor][:cli][:configtype] = 's3'
#   node[:exhibitor][:s3][:key] = 'key'
#   node[:exhibitor][:s3][:secret] = 'secret'
#   node[:exhibitor][:cli][:s3config] = 'example-bucket:fake/path'
#   node[:exhibitor][:cli][:s3region] = 'us-west-1'

# What gets rendered to node[:exhibitor][:cli][:defaultconfig]
default[:exhibitor][:config] = {
  cleanup_period_ms: 5 * 60 * 1000,
  check_ms: '30000',
  backup_period_ms: '0',
  client_port: '2181',
  cleanup_max_files: '20',
  backup_max_store_ms: '0',
  connect_port: '2888',
  backup_extra: '',
  observer_threshold: '0',
  election_port: '3888',
  zoo_cfg_extra: 'tickTime\=2000&initLimit\=10&syncLimit\=5',
  auto_manage_instances_settling_period_ms: '0',
  auto_manage_instances: '1',
  servers_spec: "1:#{node[:ipaddress]}"
}
