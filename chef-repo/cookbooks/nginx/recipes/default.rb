#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# make a safe download directory
directory node['nginx']['download_path'] do
  owner	  'root'
  group	  'root'
  action  :create
  mode	  "0755"
end

file_name = "nginx-#{node['nginx']['version']}.tar.gz"
src_path = "#{node['nginx']['download_path']}/#{file_name}"
src_url = "http://nginx.org/download/#{file_name}"
src_directory = "nginx-#{node['nginx']['version']}"

# download the tarball
remote_file src_path do
  source    src_url
  action    :create_if_missing
end

# untar it
bash "untar src code" do
  cwd	    node['nginx']['download_path']
  user	    "root"
  code	    "if [ ! -d #{src_directory} ]; then tar xzvf #{file_name}; fi"
  action    :run
end

package "gcc" do
  action      :install
end

bash "magic" do
  cwd	     "#{node['nginx']['download_path']}/#{src_directory}"
  user	     "root"
  code	     "./configure"
end
