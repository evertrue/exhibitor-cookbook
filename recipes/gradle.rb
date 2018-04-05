#
# Cookbook Name:: exhibitor
# Recipe:: gradle
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

include_recipe 'et_gradle'

jar_path = "#{node['exhibitor']['install_dir']}/#{node['exhibitor']['version']}.jar"
build_path = file_cache_path 'exhibitor'

directory build_path

template "#{build_path}/build.gradle" do
  variables version: node['exhibitor']['version']
end

execute 'build exhibitor' do
  cwd     build_path
  command "#{node['et_gradle']['home_dir']}/bin/gradle shadowJar"
  not_if  { File.exist? jar_path }
end

gradle_artifact = "#{build_path}/build/libs/exhibitor-#{node['exhibitor']['version']}-all.jar"

execute "cp #{gradle_artifact} #{jar_path}" do
  not_if { File.exist? jar_path }
end

file jar_path do
  user    node['exhibitor']['user']
  only_if { File.exist? jar_path }
end
