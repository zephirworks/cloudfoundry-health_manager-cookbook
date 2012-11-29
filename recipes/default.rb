#
# Cookbook Name:: cloudfoundry-health_manager
# Recipe:: default
#
# Copyright 2012, ZephirWorks
# Copyright 2012, Trotter Cashion
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

#
# Install the correct rbenv
#
ruby_ver = node['cloudfoundry_health_manager']['ruby_version']
ruby_path = ruby_bin_path(ruby_ver)

include_recipe "cloudfoundry-cloud_controller::install_deps"

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby ruby_ver

#
# Create all the directories we are going to need
#
%w[log_dir].each do |d|
  directory node['cloudfoundry'][d] do
    recursive true
    owner node['cloudfoundry']['user']
    mode  0755
  end
end
%w[data_dir].each do |d|
  directory node['cloudfoundry_cloud_controller'][d] do
    recursive true
    owner node['cloudfoundry']['user']
    mode  '0755'
  end
end
%w[droplets_dir resources_dir staging_manifests_dir tmp_dir].each do |d|
  directory node['cloudfoundry_cloud_controller']['server'][d] do
    recursive true
    owner node['cloudfoundry']['user']
    mode  '0755'
  end
end

#
# Install and configure
#
cloudfoundry_source "health_manager" do
  path          node['cloudfoundry_health_manager']['vcap']['install_path']
  repository    node['cloudfoundry_health_manager']['vcap']['repo']
  reference     node['cloudfoundry_health_manager']['vcap']['reference']
  subdirectory  "health_manager"
end

br = bash "install extra gems for health_manager" do
  user node['cloudfoundry_health_manager']['user']
  cwd  File.join(node['cloudfoundry_health_manager']['vcap']['install_path'], "cloud_controller")
  code "#{::File.join(ruby_path, "bundle")} install --without=test --standalone"
  action :nothing
  subscribes :run, resources(:cloudfoundry_source => "health_manager")
end

install_path = File.join(node['cloudfoundry_health_manager']['vcap']['install_path'], "health_manager")

cloudfoundry_component "health_manager" do
  install_path install_path
  bin_file File.join(install_path, "bin", "health_manager")
  pid_file node['cloudfoundry_health_manager']['pid_file']
  log_file node['cloudfoundry_health_manager']['log_file']
  subscribes    :restart, resources(:cloudfoundry_source => "health_manager")
end
