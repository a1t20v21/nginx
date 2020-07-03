# when we disable an nginx vhost, it will fail back to the default site as testvhost2.com is pointing to 127.0.0.1
describe file('/etc/nginx/nginx.conf') do
  its('content') { should_not match /include \/etc\/nginx\/conf.d\/testvhost2.com.conf;/ }
end

describe command('curl http://testvhost2.com') do
  its('stdout') { should_not match /testvhost2.com/ }
end