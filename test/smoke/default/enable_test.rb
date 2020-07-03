describe file('/etc/nginx/nginx.conf') do
  its('content') { should match /include \/etc\/nginx\/conf.d\/testvhost1.com.conf;/ }
end

describe file('/etc/nginx/nginx.conf') do
  its('content') { should match /include \/etc\/nginx\/conf.d\/testvhost2.com.conf;/ }
end

describe command('curl http://testvhost1.com') do
  its('stdout') { should match /testvhost1.com/ }
  its('exit_status') { should eq 0 }
end

describe command('curl http://testvhost2.com') do
  its('stdout') { should match /testvhost2.com/ }
  its('exit_status') { should eq 0 }
end