describe file('/etc/nginx/conf.d/testvhost1.com.conf') do
  its('content') { should match /server_name\s.*?testvhost1.com/ }
end

describe file('/etc/nginx/conf.d/testvhost2.com.conf') do
  its('content') { should match /server_name\s.*?testvhost2.com/ }
end