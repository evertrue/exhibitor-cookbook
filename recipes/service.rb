#
# Cookbook Name:: exhibitor
# Recipe:: service
#
# Copyright 2014, Simple Finance Technology Corp.
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

service_conf = {
  user:      node['exhibitor']['user'],
  jar:       "#{node['exhibitor']['install_dir']}/#{node['exhibitor']['version']}.jar",
  log4j:     "#{node['exhibitor']['install_dir']}/log4j.properties",
  cli:       shell_opts(node['exhibitor']['cli']),
  java_home: node['java']['java_home'],
}

service_conf[:java_home] = '/usr' if service_conf[:java_home].nil?

case node['exhibitor']['service_style']
when 'upstart'
  template '/etc/init/exhibitor.conf' do
    source    'exhibitor.upstart.erb'
    owner     'root'
    group     'root'
    variables service_conf
    mode      '0644'
    notifies  :restart, 'service[exhibitor]', :delayed
  end

  service 'exhibitor' do
    provider Chef::Provider::Service::Upstart
    supports status: true, restart: true, reload: true
    action   node['exhibitor']['service_actions']
  end
when 'runit'
  include_recipe 'runit::default'

  runit_service 'exhibitor' do
    default_logger true
    options        service_conf
    action         node['exhibitor']['service_actions']
  end
when 'systemd'
  template '/etc/systemd/system/exhibitor.service' do
    source    'exhibitor.systemd.erb'
    owner     'root'
    group     'root'
    variables service_conf
    mode      '0644'
    notifies  :restart, 'service[exhibitor]', :delayed
  end

  service 'exhibitor' do
    provider Chef::Provider::Service::Systemd
    supports status: true, restart: true, reload: true
    action   node['exhibitor']['service_actions']
  end
else
  Chef::Log.error('You specified an invalid service style for Exhibitor, but I am continuing.')
end
