instances = []

(1..3).each do |n| 
  instances.push({
    :name => "n#{n}",
    :ip => "192.168.10.#{n+10}",
  })
end

Vagrant.configure("2") do |config|
  instances.each do |instance|
    config.vm.define instance[:name] do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = instance[:name]
      node.vm.network "private_network", ip: "#{instance[:ip]}"

      file_to_disk = "/tmp/vdisk#{instance[:name]}.hdi"
      node.vm.provider :virtualbox do |vb|
        if not File.exist?(file_to_disk)
          vb.customize ['createhd', '--filename', file_to_disk, '--size', 2 * 1024]
        end
        vb.customize ['storagectl', :id, '--name', 'SATA', '--add', 'sata']
        vb.customize ['storageattach', :id, '--storagectl', 'SATA', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
      end

      node.vm.provision "shell", path: "install.sh"
      node.vm.provision "shell", path: "startup.sh"
    end
  end
end
