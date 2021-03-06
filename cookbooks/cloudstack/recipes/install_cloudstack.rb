#
# Cookbook Name:: cloudstack
# Recipe:: install_cloustack
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

rightscale_marker :begin

cloudstack_tarfile = ::File.join(ENV['TMPDIR'] || '/tmp', 'cloudstack.tar.gz')

file cloudstack_tarfile do
  backup false
  action :nothing
end

directory node[:cloudstack][:install_dir] do
  action :create
end

unless ::File.exists?(::File.join("#{node[:cloudstack][:install_dir]}", "install.sh"))
  # Download/unzip CloudStack file
  remote_file cloudstack_tarfile do
    source node[:cloudstack][:csmanage][:package_url]
  end

  bash "Unzip CloudStack File" do
    code "tar -zxf #{cloudstack_tarfile} -C #{node[:cloudstack][:install_dir]} --strip-components=1"
    notifies :delete, "file[#{cloudstack_tarfile}]", :immediately
  end
end

rightscale_marker :end