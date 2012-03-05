#
# Cookbook Name:: cloudstack
# Recipe:: setup_single_node_management_server
#
#  Copyright 2012 Ryan J. Geyer
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

rs_utils_marker :begin

node[:openvpn] ||= {}

node[:openvpn][:local]    = node[:cloudstack][:csmanage][:vpn][:listen_ip]
node[:openvpn][:netmask]  = node[:cloudstack][:csmanage][:vpn][:netmask]
node[:openvpn][:subnet]   = node[:cloudstack][:csmanage][:vpn][:subnet]
node[:openvpn][:protocol] = "udp"
node[:openvpn][:type]     = "server"
node[:openvpn][:users]    = ["remote"]
node[:openvpn][:gateway]  = node[:cloudstack][:csmanage][:vpn][:hostname]

include_recipe "cloudstack::setup_management_server"
include_recipe "openvpn::setup_server"
include_recipe "openvpn::users"

sys_firewall "Open UDP port 1194 for OpenVPN server" do
  port 1194
  protocol "udp"
  enable true
  action :update
end

rs_utils_marker :end