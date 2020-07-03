module NginxInstallation
  module Helpers
    def package_epel_release
      'epel-release'
    end

    def package_nginx
      'nginx'
    end

    def service_nginx
       'nginx'
    end
  end
end