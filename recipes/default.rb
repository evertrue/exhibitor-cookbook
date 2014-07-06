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

package 'patch' do
  action :nothing
end.run_action(:install)

include_recipe 'zookeeper::default'

[
  node[:exhibitor][:install_dir],
  node[:exhibitor][:snapshot_dir],
  node[:exhibitor][:transaction_dir],
  node[:exhibitor][:log_index_dir]
].uniq.each do |dir|
  directory dir do
    owner node[:exhibitor][:user]
    mode 00700
  end
end

node.default[:exhibitor][:jar_dest] = ::File.join(node[:exhibitor][:install_dir],
                                                  "#{node[:exhibitor][:version]}.jar")

if node[:exhibitor][:install_method] == 'download'
  remote_file node[:exhibitor][:jar_dest] do
    owner 'root'
    mode 00600
    source node[:exhibitor][:mirror]
    checksum node[:exhibitor][:checksum]
    action :create
  end
else
  include_recipe 'exhibitor::_exhibitor_build'
end

if node[:exhibitor][:cli][:configtype] != 'file'
  node.default[:exhibitor][:cli].delete(:fsconfigdir)
end

case node[:exhibitor][:cli][:configtype]
when 's3'
  if node[:exhibitor][:s3key] && node[:exhibitor][:s3secret]
    node.default[:exhibitor][:cli][:s3credentials] = s3_creds
    file ::File.join(node[:exhibitor][:install_dir], 'exhibitor.s3.properties') do
      owner node[:exhibitor][:user]
      mode 00400
      content render_s3_credentials
s3key: node[:exhibitor][:s3]
com.netflix.exhibitor.s3.access-key-id=
com.netflix.exhibitor.s3.access-secret-key=<%= @s3secret %>
s3secret: node[:exhibitor][:s3secret]
      eos
    end
  end
when 'file'
else
  Chef::Log.warn('Unsure what configtype to use (S3 or file) for Exhibitor; choosing file.')

end

template ::File.join(node[:exhibitor][:install_dir], 'log4j.properties') do
  source 'log4j.properties.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    loglevel: node[:exhibitor][:loglevel]
  )
end

# Write these values out as late as possible since their values can change.
node.default[:exhibitor][:config].merge!({
  log_index_directory: node[:exhibitor][:log_index_dir],
  zookeeper_log_directory: node[:exhibitor][:transaction_dir],
  zookeeper_snapshot_directory: node[:exhibitor][:snapshot_dir],
  zookeeper_install_directory: "#{node[:zookeeper][:install_dir]}/*",
})

file node[:exhibitor][:cli][:defaultconfig] do
  owner node[:exhibitor][:user]
  mode 00400
  content render_config(node[:exhibitor][:config])
end
