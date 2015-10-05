# recipes/gradle.rb
#
# Copyright 2014, Simple Finance Technology Corp.
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

class Chef::Recipe
  include Exhibitor::Util
end

if should_install_gradle?
  package 'unzip' do
    action :install
  end

  node.default['gradle']['mirror'] = "http://services.gradle.org/distributions/gradle-#{node['gradle']['version']}-bin.zip"
  remote_file ::File.join(Chef::Config[:file_cache_path], 'gradle.zip') do
    owner 'root'
    mode 00644
    source node['gradle']['mirror']
    checksum node['gradle']['checksum']
  end

  execute 'unzip gradle' do
    cwd Chef::Config[:file_cache_path]
    command 'unzip ./gradle.zip'
  end

  gradle_binary = ::File.join(Chef::Config[:file_cache_path],
                              "gradle-#{node['gradle']['version']}",
                              'bin', 'gradle')

  link '/usr/local/bin/gradle' do
    to gradle_binary
  end
end
