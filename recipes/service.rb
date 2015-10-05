# recipes/service.rb
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

class Chef::Resource
  include Exhibitor::Util
end

include_recipe 'runit::default'

runit_service 'exhibitor' do
  default_logger true
  options(
    user: node['exhibitor']['user'],
    jar: ::File.join(node['exhibitor']['install_dir'],
                     "#{node['exhibitor']['version']}.jar"),
    log4j: ::File.join(node['exhibitor']['install_dir'], 'log4j.properties'),
    cli: format_cli_options(node['exhibitor']['cli'])
  )
  action node['exhibitor']['service_actions']
end
