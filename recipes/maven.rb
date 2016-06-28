#
# Cookbook Name:: exhibitor
# Recipe:: maven
#
# Copyright (c) 2016 EverTrue, Inc.
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
#

include_recipe 'maven'

build_path = file_cache_path 'exhibitor'

directory build_path

template "#{build_path}/pom.xml" do
  variables version: node['exhibitor']['version']
end

execute 'build exhibitor' do
  cwd     build_path
  command 'mvn clean package'
  not_if  { File.exist? node['exhibitor']['jar_dest'] }
end

mvn_artifact = "#{build_path}/target/exhibitor-#{node['exhibitor']['version']}.jar"

execute "cp #{mvn_artifact} #{node['exhibitor']['jar_dest']}" do
  not_if { File.exist? node['exhibitor']['jar_dest'] }
end

file node['exhibitor']['jar_dest'] do
  user    node['exhibitor']['user']
  only_if { File.exist? node['exhibitor']['jar_dest'] }
end
