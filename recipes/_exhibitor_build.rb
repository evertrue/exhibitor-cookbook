# recipes/_exhibitor_build.rb
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

if should_install_exhibitor?(node['exhibitor']['jar_dest'])
  # We need Gradle to build the artifact.
  include_recipe 'exhibitor::gradle'

  build_path = ::File.join(Chef::Config[:file_cache_path], 'exhibitor')

  directory build_path do
    owner node['exhibitor']['user']
    mode 00700
  end

  template ::File.join(build_path, 'build.gradle') do
    owner 'root'
    variables version: node['exhibitor']['version']
  end

  execute 'build exhibitor' do
    user 'root'
    cwd build_path
    command 'gradle shadowJar'
  end

  gradle_artifact = ::File.join(build_path,
                                'build',
                                'libs',
                                "exhibitor-#{node['exhibitor']['version']}-all.jar")

  execute 'move exhibitor jar' do
    command "cp #{gradle_artifact} #{node['exhibitor']['jar_dest']} " \
            "&& chown #{node['exhibitor']['user']} #{node['exhibitor']['jar_dest']}"
  end
end
