#
# Cookbook Name:: cloudfoundry-health_manager
# Attributes:: default
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

include_attribute "cloudfoundry"

# Where to install the CloudFoundry code.
default['cloudfoundry_health_manager']['vcap']['install_path'] = "/srv/vcap-health_manager"

# Repository to use when fetching the CloudFoundry code.
default['cloudfoundry_health_manager']['vcap']['repo']         = "https://github.com/cloudfoundry/cloud_controller.git"

# Git reference to use when fetching the CloudFoundry code. Can be
# either a specific sha or a reference such as `HEAD` or `master`.
default['cloudfoundry_health_manager']['vcap']['reference']    = "31ab65cdf0b9863677675b3812aac7305001267e"

# The Health Manager's log level.
default['cloudfoundry_health_manager']['log_level'] = "info"

# Where to write the Health Manager's logs.
default['cloudfoundry_health_manager']['log_file'] = File.join(node['cloudfoundry']['log_dir'], "health_manager.log")

# Where to write the Health Manager's pid file.
default['cloudfoundry_health_manager']['pid_file'] = File.join(node['cloudfoundry']['pid_dir'], "health_manager.pid")

# TODO (trotter): Find out what this does.
default['cloudfoundry_health_manager']['database_scan']    = 60

# TODO (trotter): Find out what this does.
default['cloudfoundry_health_manager']['droplet_lost']     = 30

# TODO (trotter): Find out what this does.
default['cloudfoundry_health_manager']['droplet_analysis'] = 10

# TODO (trotter): Find out what this does.
default['cloudfoundry_health_manager']['flapping_death']   = 3

# TODO (trotter): Find out what this does.
default['cloudfoundry_health_manager']['flapping_timeout'] = 180

# TODO (trotter): Find out what this does.
default['cloudfoundry_health_manager']['restart_timeout']  = 20

# TODO (trotter): Find out what this does.
default['cloudfoundry_health_manager']['stable_state']     = 60
