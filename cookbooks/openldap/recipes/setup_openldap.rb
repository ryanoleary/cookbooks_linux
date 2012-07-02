#
# Cookbook Name:: openldap
# Recipe:: setup_openldap
#
# Copyright 2011, Ryan J. Geyer
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

rightscale_marker :begin

include_recipe "rs_sandbox::default"

if ::File.directory? node[:rs_sandbox][:home]
  load_ruby_gem_into_rs_sandbox("net-ldap", "0.2.2", nil, true)
end

g = gem_package "net-ldap" do
  version "0.2.2"
end

g.run_action(:install)

Gem.clear_paths
require "net-ldap"

rightscale_marker :end