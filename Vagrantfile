# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |global_config|
  global_config.vm.box = "precise64"
  global_config.vm.box_url = "https://www.dropbox.com/s/957slyhxn5f4mgi/precise64.box"

  # Forward guest port 80 to host port 4567 and name the mapping "web"

  global_config.vm.define :rails_app do |config|
    config.vm.forward_port  80, 4567
    config.vm.forward_port 8080, 4568

    config.vm.customize [ "modifyvm", :id, "--memory", 256 ]

    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path ="cookbooks"

      #chef.add_recipe "proxy"
      chef.add_recipe "application"

      chef.json.merge!({
          :java => {
            :install_flavor => "sun"
          },
          :mysql => {
            :bind_address => "127.0.0.1"
          }
      })
    end
  end
end