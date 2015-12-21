# recipes/default.rb
#
# Copyright 2014, Simple Finance Technology Corp.
# Copyright 2014, Continuuity Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Chef::Resource
  include Exhibitor::Util
end

package node['exhibitor']['patch_package']

include_recipe 'zookeeper::install'

[
  node['exhibitor']['install_dir'],
  node['exhibitor']['snapshot_dir'],
  node['exhibitor']['transaction_dir'],
  node['exhibitor']['log_index_dir']
].uniq.each do |dir|
  directory dir do
    owner node['exhibitor']['user']
    recursive true
    mode 00700
  end
end

node.override['exhibitor']['jar_dest'] = ::File.join(node['exhibitor']['install_dir'],
                                                     "#{node['exhibitor']['version']}.jar")

if node['exhibitor']['install_method'] == 'download'
  remote_file node['exhibitor']['jar_dest'] do
    owner node['exhibitor']['user']
    mode 00600
    source node['exhibitor']['mirror']
    checksum node['exhibitor']['checksum']
  end
else
  include_recipe 'exhibitor::_exhibitor_build'
end

case node['exhibitor']['cli']['configtype']
when 's3'
  if node['exhibitor']['s3']
    s3_properties = ::File.join(node['exhibitor']['install_dir'], 'exhibitor.s3.properties')
    node.default['exhibitor']['cli']['s3credentials'] = s3_properties

    file s3_properties do
      owner node['exhibitor']['user']
      mode 00400
      content render_s3_credentials(node['exhibitor']['s3'])
    end
  else
    Chef::Log.warn 'No S3 credentials given. Assuming instance has permissions to S3.'
  end
when 'file'
  node.default['exhibitor']['cli']['fsconfigdir'] = '/tmp'
  node.default['exhibitor']['cli']['fsconfigname'] = 'exhibitor.properties'

  file ::File.join(node['exhibitor']['cli'][:fsconfigdir], node['exhibitor']['cli'][:fsconfigname]) do
    owner node['exhibitor']['user']
    mode 00600
  end
else
  Chef::Log.error 'Unsure what configtype to use (S3 or file) for Exhibitor, but will continue.'
end

template ::File.join(node['exhibitor']['install_dir'], 'log4j.properties') do
  source 'log4j.properties.erb'
  owner node['exhibitor']['user']
  mode 00600
  variables loglevel: node['exhibitor']['loglevel']
end

# Write these values out as late as possible since their values can change.
node.default['exhibitor']['config'].merge!(
  'log_index_directory' => node['exhibitor']['log_index_dir'],
  'zookeeper_log_directory' => node['zookeeper']['config']['dataLogDir'] || node['exhibitor']['transaction_dir'],
  'zookeeper_data_directory' => node['zookeeper']['config']['dataDir'] || node['exhibitor']['snapshot_dir'],
  'zookeeper_install_directory' => "#{node['zookeeper']['install_dir']}/*",
)

file node['exhibitor']['cli']['defaultconfig'] do
  owner node['exhibitor']['user']
  mode 00600
  content render_properties_file(node['exhibitor']['config'])
end
