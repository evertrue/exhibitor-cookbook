#
# Cookbook Name:: exhibitor
# Recipe:: default
#
# Copyright 2014, Simple Finance Technology Corp.
# Copyright 2014, Continuuity Inc.
# Copyright 2016, EverTrue, Inc.
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

package node['exhibitor']['patch_package']

zookeeper node['exhibitor']['zookeeper_version'] do
  username  node['exhibitor']['user']
  user_home "/home/#{node['exhibitor']['user']}"
  install_dir node['zookeeper']['install_dir']
  mirror node['zookeeper']['mirror'] if node['zookeeper']['mirror']
end

[
  node['exhibitor']['install_dir'],
  node['exhibitor']['snapshot_dir'],
  node['exhibitor']['transaction_dir'],
  node['exhibitor']['log_index_dir'],
].uniq.each do |dir|
  directory dir do
    owner node['exhibitor']['user']
    recursive true
    mode 00700
  end
end

case node['exhibitor']['install_method']
when 'gradle'
  include_recipe 'exhibitor::gradle'
when 'maven'
  include_recipe 'exhibitor::maven'
end

case node['exhibitor']['cli']['configtype']
when 's3'
  if node['exhibitor']['s3']
    s3_properties = ::File.join(node['exhibitor']['install_dir'], 'exhibitor.s3.properties')
    node.default['exhibitor']['cli']['s3credentials'] = s3_properties

    file s3_properties do
      owner node['exhibitor']['user']
      mode 00400
      content(
        node['exhibitor']['s3'].map do |k, v|
          "com.netflix.exhibitor.s3.#{k}=#{v}"
        end.join("\n")
      )
    end
  else
    Chef::Log.warn 'No S3 credentials given. Assuming instance has permissions to S3.'
  end
when 'file'
  node.default['exhibitor']['cli']['fsconfigdir'] = '/tmp'
  node.default['exhibitor']['cli']['fsconfigname'] = 'exhibitor.properties'

  file ::File.join(node['exhibitor']['cli']['fsconfigdir'], node['exhibitor']['cli']['fsconfigname']) do
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
  'log-index-directory' => node['exhibitor']['log_index_dir'],
  'zookeeper-log-directory' => node['zookeeper']['config']['dataLogDir'] ||
                               node['exhibitor']['transaction_dir'],
  'zookeeper-data-directory' => node['zookeeper']['config']['dataDir'] ||
                                node['exhibitor']['snapshot_dir'],
  'zookeeper-install-directory' => "#{node['zookeeper']['install_dir']}/*"
)

file node['exhibitor']['cli']['defaultconfig'] do
  owner node['exhibitor']['user']
  mode 00600
  content properties_config(node['exhibitor']['config'])
end
