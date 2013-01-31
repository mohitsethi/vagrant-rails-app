# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  #config.vm.box_url = ""

  # Forward guest port 80 to host port 4567 and name the mapping "web"
  config.vm.forward_port  80, 4567
  config.vm.forward_port 8080, 4568

  config.vm.customize [ "modifyvm", :id, "--memory", 256 ]

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path ="cookbooks"

    chef.add_recipe "proxy"
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