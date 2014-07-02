default[:gradle][:version] = '1.5'
default[:gradle][:mirror] = "http://services.gradle.org/distributions/gradle-#{default[:gradle][:version]}-bin.zip"
default[:gradle][:checksum] = 'a5511a0659caa47d9d74fd2844c9da43157d2f78e63a0223c6289d88f5aaecbe'

default[:exhibitor][:user] = 'zookeeper'
default[:exhibitor][:group] = 'zookeeper'

# Exhibitor install options:
#   'download' or 'build'
#   build will pull down gradle and build exhibitor on the server
default[:exhibitor][:install_method] = 'build'

default[:exhibitor][:version] = "1.5.0"
default[:exhibitor][:install_dir] = "/opt/exhibitor"
default[:exhibitor][:script_dir] = '/usr/local/bin/'

default[:exhibitor][:snapshot_dir] = '/tmp/zookeeper'
default[:exhibitor][:transaction_dir] = '/tmp/zookeeper'
default[:exhibitor][:log_index_dir] = '/tmp/zookeeper_log_indexes'
default[:exhibitor][:log_to_syslog] = '1'

# Port for the HTTP Server
default[:exhibitor][:opts][:port] = '8080'
default[:exhibitor][:opts][:hostname] =  node[:ipaddress]
default[:exhibitor][:opts][:defaultconfig] = "#{node[:exhibitor][:install_dir]}/exhibitor.properties"

default[:exhibitor][:opts][:configtype] = 'file'

default[:exhibitor][:loglevel] = 'info'

# For --configtype s3, set:
# [:exhibitor][:s3key] = "key"
# [:exhibitor][:s3secret] = "secret"
# [:exhibitor][:opts][:s3config] = "bucket:config-key"
# [:exhibitor][:opts][:s3region] = "region" # i.e. us-east-1

# For --contiftype file
default[:exhibitor][:opts][:fsconfigdir] = '/tmp'

default[:exhibitor][:defaultconfig][:cleanup_period_ms] = 5 * 60 * 1000
default[:exhibitor][:defaultconfig][:zookeeper_install_directory] = "#{node[:zookeeper][:install_dir]}/*"
default[:exhibitor][:defaultconfig][:check_ms] = '30000'
default[:exhibitor][:defaultconfig][:backup_period_ms] = '0'
default[:exhibitor][:defaultconfig][:client_port] = '2181'
default[:exhibitor][:defaultconfig][:cleanup_max_files] = '20'
default[:exhibitor][:defaultconfig][:backup_max_store_ms] = '0'
default[:exhibitor][:defaultconfig][:connect_port] = '2888'
default[:exhibitor][:defaultconfig][:backup_extra] = ''
default[:exhibitor][:defaultconfig][:observer_threshold] = '0'
default[:exhibitor][:defaultconfig][:election_port] = '3888'
default[:exhibitor][:defaultconfig][:zoo_cfg_extra] = 'tickTime\=2000&initLimit\=10&syncLimit\=5'
default[:exhibitor][:defaultconfig][:auto_manage_instances_settling_period_ms] = '0'
default[:exhibitor][:defaultconfig][:auto_manage_instances] = '1'
default[:exhibitor][:defaultconfig][:servers_spec] = "1:#{node[:ipaddress]}"
