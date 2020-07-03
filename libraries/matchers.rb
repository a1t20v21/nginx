if defined?(ChefSpec)
  def create_nginx_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_install, :create, resource_name)
  end

  def create_nginx_vhosts(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_vhosts, :create, resource_name)
  end

  def enable_nginx_vhosts(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_vhosts, :enable, resource_name)
  end

  def disable_nginx_vhosts(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_vhosts, :disable, resource_name)
  end
end