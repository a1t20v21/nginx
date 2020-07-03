include NginxInstallation::Helpers

property :homepage, String, default: '<h1>Hello world!!!!</h1>'

default_action :create

load_current_value do
  if ::File.exist?('/usr/share/nginx/html/index.html')
    homepage IO.read('/usr/share/nginx/html/index.html')
  end
end

action :create do
  package package_epel_release
  package package_nginx

  service service_nginx do
    action [:enable, :start]
  end

  file '/usr/share/nginx/html/index.html' do
    content homepage
  end

  template "/etc/nginx/nginx.conf" do
    source 'nginx.conf.main.erb'
    cookbook "nginx"
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end

end

action :delete do
  package 'nginx' do
    action :delete
  end
end
