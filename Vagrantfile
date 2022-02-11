require './config.rb'

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.provision "shell", path: "./provision.sh"

  Hosts.each do |host|
    config.vm.define host[:hostname] do |c|
      c.vm.hostname = host[:hostname]
      c.vm.network "private_network", ip: host[:private_ip]
      c.vm.network "forwarded_port", id: "ssh", guest: 22, host: host[:ssh_forward_port]

      c.vm.provider "virtualbox" do |v|
        v.cpus = host[:cpus]
        v.memory = host[:memory_mb]

        if host.has_key?(:external_disk_size_mb)
          vdi_path = "./disks/ext_#{host[:hostname]}.vdi"
          if not File.exist?(vdi_path)
            v.customize ["createvdi", "--filename", vdi_path, "--size", host[:external_disk_size_mb]]
          end
          v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', vdi_path]
        end
      end
    end
  end
end
