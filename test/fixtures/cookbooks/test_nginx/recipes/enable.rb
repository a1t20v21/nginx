nginx_vhosts 'testvhost1' do
  action  :enable
  listen      '80'
  server_name 'testvhost1.com'
  root_dir    '/var/www/testvhost1/html'
  index_file '/var/www/testvhost1/html/index.html'
end

nginx_vhosts 'testvhost2' do
  action  :enable
  listen      '80'
  server_name 'testvhost2.com'
  root_dir    '/var/www/testvhost2/html'
  index_file '/var/www/testvhost2/html/index.html'
end

# The below code is for purpose of running functional tests only.
# We add "testvhost1.com" as our test virtual host in nginx and the functional
# test tries to access this domain name. To resolve the name, we add the domain name
# to the /etc/hosts file

ruby_block "edit /etc/hosts for for resolving testvhost1.com" do
  block do
      content = ::File.open("/etc/hosts", "rb").read
      new_contents = content.gsub(
          /127.0.0.1/, "127.0.0.1 testvhost1.com testvhost2.com")
      ::File.open("/etc/hosts", 'w') {|file| file.puts new_contents }
  end
end
