#
# Cookbook Name:: application
# Recipe:: default
#
# Copyright:: 2012, Opscode, Inc <legal@opscode.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Empty placeholder recipe, use the LWRPs, see README.md.
# ensure the local APT package cache is up to date
  include_recipe 'apt'
  # install ruby_build tool which we will use to build ruby
  include_recipe 'ruby_build'
  ruby_build_ruby '1.9.3-p362' do
    prefix_path '/usr/local/'
    environment 'CFLAGS' => '-g -O2'
    action :install
  end
  gem_package 'bundler' do
    version '1.2.3'
    gem_binary '/usr/local/bin/gem'
    options '--no-ri --no-rdoc'
  end
  # we create new user that will run our application server
  user_account 'deployer' do
    create_group true
    ssh_keygen false
  end
  # we define our application using application resource provided by application cookbook
  application 'app' do
    owner 'deployer'
    group 'deployer'
    path '/home/deployer/app'
    revision 'chef_demo'
    repository 'git://github.com/mohitsethi/rails-example-app.git'
    rails do
      bundler true
    end
    unicorn do
      worker_processes 2
    end
  end