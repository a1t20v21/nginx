#
# Cookbook:: nginx
# Spec:: default
#
# Copyright:: 2017, a1t20v21, All Rights Reserved.

require 'spec_helper'

shared_examples 'nginx_install' do
  context "when run on centos-7.3" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates the default web site' do
      expect(chef_run).to create_nginx_install 'default'
    end
  end
end

shared_examples 'nginx_vhosts_create_example' do
  context "when run on centos-7.3" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates vhost testvhost1' do
      expect(chef_run).to create_nginx_vhosts 'testvhost1'
    end

    it 'creates vhost testvhost2' do
      expect(chef_run).to create_nginx_vhosts 'testvhost2'
    end
  end
end

shared_examples 'nginx_vhosts_enable_example' do
  context "when run on centos-7.3" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge(described_recipe)
    end

    it 'enables vhost testvhost1' do
      expect(chef_run).to enable_nginx_vhosts 'testvhost1'
    end

    it 'enables vhost testvhost2' do
      expect(chef_run).to enable_nginx_vhosts 'testvhost2'
    end
  end
end

shared_examples 'nginx_vhosts_disable_example' do
  context "when run on centos-7.3" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge(described_recipe)
    end
    it 'disables vhost testvhost2' do
      expect(chef_run).to disable_nginx_vhosts 'testvhost2'
    end
  end
end


describe 'test_nginx::default' do
  include_examples 'nginx_install', 'centos', '7.3.1611'
end

describe 'test_nginx::create' do
  include_examples 'nginx_vhosts_create_example', 'centos', '7.3.1611'
end


describe 'test_nginx::enable' do
  include_examples 'nginx_vhosts_enable_example', 'centos', '7.3.1611'
end

describe 'test_nginx::disable' do
  include_examples 'nginx_vhosts_disable_example', 'centos', '7.3.1611'
end


