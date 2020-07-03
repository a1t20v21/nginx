resource_name :nginx_vhosts
include NginxInstallation::Helpers

property :listen, String
property :server_name, String
property :root_dir, String
property :homepage, String
property :index_file, String

#default_action :create

#load_current_value do
#  if ::File.exist?(index_file)
#    homepage IO.read(index_file)
#  end
#end


action :create do
  converge_by("Creating #{server_name}") do
    create_vhosts
  end
  restart_nginx
end

action :enable do
  if not enabled?
    converge_by("Creating and Enabling #{server_name}") do
      Chef::Log.info("Creating #{server_name}")
      create_vhosts
      Chef::Log.info("Enabling #{server_name}")
      enable_vhosts
      restart_nginx
    end
  end
end

action :disable do
  if enabled?
    converge_by("Disabling #{server_name}") do
      disable_vhosts
      restart_nginx
    end
  end
end

action_class do

  def create_vhosts

    directory root_dir do
      recursive true
      owner 'nginx'
      group 'nginx'
      mode '0755'
      action :create
    end

    file index_file do
      content "<h1>Hello world from #{server_name} !!!!</h1>"
    end

    template "/etc/nginx/conf.d/#{server_name}.conf" do
      source 'nginx_server_block.conf.erb'
      cookbook "nginx"
      variables(
          server_name: server_name,
          listen: listen,
          root_dir: root_dir
      )
      owner 'root'
      group 'root'
      mode '0644'
      action :create
    end

  end

  def enable_vhosts
      content = ::File.open("/etc/nginx/nginx.conf", "rb").read
      new_contents = content.gsub(
          /VHOSTS_CONF_BELOW/, "VHOSTS_CONF_BELOW\n\s\sinclude /etc/nginx/conf.d/#{server_name}.conf;")
      ::File.open("/etc/nginx/nginx.conf", 'w') {|file| file.puts new_contents }
  end

  def disable_vhosts
    puts "\n#{server_name}"
    #Chef::Util::FileEdit.new("/etc/nginx/nginx.conf").search_file_delete_line(/"#{server_name}.conf"/)
    content = ::File.open("/etc/nginx/nginx.conf", "rb").read
    new_contents = content.gsub(
        /include\ \/etc\/nginx\/conf.d\/#{server_name}.conf;/, "")
    ::File.open("/etc/nginx/nginx.conf", 'w') {|file| file.puts new_contents }
  end

  def restart_nginx
    service service_nginx do
      action :restart
    end
  end

  def enabled?
    return ::File.readlines("/etc/nginx/nginx.conf").grep(/#{server_name}/).any?
  end
end
