
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

%w{gcc pcre-devel zlib-devel}.each do |pkg|
  package pkg do
    action      :install
  end
end

bash "configure" do
  cwd	     "#{node['nginx']['download_path']}/#{src_directory}"
  user	     "root"
  code	     <<-EOC
  if [ ! -f Makefile ]; then ./configure --prefix=#{node['nginx']['prefix']}; fi
  make
  make install
  EOC
end

