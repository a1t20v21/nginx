nginx_vhosts 'testvhost1' do
  action  :create
  listen      '80'
  server_name 'testvhost1.com'
  root_dir    '/var/www/testvhost1/html'
  index_file '/var/www/testvhost1/html/index.html'
end

nginx_vhosts 'testvhost2' do
  action  :create
  listen      '80'
  server_name 'testvhost2.com'
  root_dir    '/var/www/testvhost2/html'
  index_file '/var/www/testvhost2/html/index.html'
end
