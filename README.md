# nginx

This cookbook provides resources for installing nginx webserver and configuring multiple NamedVirtualHosts.
The resources include:

- nginx_install
- nginx_vhosts

#### Requirements:
- Centos7/RHEL7
- Chef 13.4+
- ChefDk
- Test Kitchen
- Docker
- chefspec
- bundler

We need the following 'gem' packages also:
- chef
- chefspec
- berkshelf
- colorize (only on local computer)

#### Create/Generate a chef repo directory structure
```bash
chef generate repo chef-repo
```

#### Create chef cookbook 'nginx'
```bash
cd chef-repo/cookbooks/
chef generate cookbook nginx
```

#### Set ruby included in chefdk as the system ruby
```bash
eval "$(chef shell-init bash)"
```

## Resources

### nginx_install

Install nginx and setup the default "catchall" domain

#### Actions:

- `create`: installs the 'epel-release' package, nginx package and sets up the default website

#### Examples:

```ruby
nginx_install 'default'
```

### nginx_vhosts

Resource to manage vhosts

#### Actions:

- `create`: creates "vhost", but do not enable it
- `enable`: enables the created vhost and reload the nginx (this action creates the vhost if it doesn't exist)
- `disable`: disables the vhost if it's enabled

#### Properties:

- `listen`: Listen port for Nginx 
- `server_name`: virtual host's name
- `root_dir`: website's document root
- `index_file`: default index file path for the website

#### Examples:

Create a new vhost

```ruby
nginx_vhosts 'testvhost1' do
  action  :create
  listen      '80'
  server_name 'testvhost1.com'
  root_dir    '/var/www/testvhost1/html'
  index_file '/var/www/testvhost1/html/index.html'
end
```

Enable the above vhost

```ruby
nginx_vhosts 'testvhost1' do
  action  :enable
  listen      '80'
  server_name 'testvhost1.com'
  root_dir    '/var/www/testvhost1/html'
  index_file '/var/www/testvhost1/html/index.html'
end
```

Disable the above vhost

```ruby
nginx_vhosts 'testvhost2' do
  action  :disable
  server_name 'testvhost2.com'
end
```



#### Validation

To validate the unit tests, use the below command:
```bash
cd chef-repo/cookbooks/nginx
chef exec rspec --color spec/unit/recipes/default_spec.rb
```

To validate the functional tests, use the below command:
```bash
cd chef-repo/cookbooks/nginx
kitchen converge && kitchen verify
```

The above command launches docker containers to run the tests. Always run `kitchen destroy all` to delete all the docker containers after running the tests.

    

    