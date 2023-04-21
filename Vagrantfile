require 'yaml'
require 'erb'

if not File.file?("config.yml")
  abort("file `config.yml` does not exist")
end
CONFIG_YML = YAML.load(ERB.new(File.read('config.yml')).result)

def check_config(host_config, required_keys)
  abort("host not defined in config.yml") if host_config.nil?
  required_keys.each do |k|
    abort("#{k} is nil") if host_config.dig(*k).nil?
  end
end

Vagrant.configure("2") do |config|
  ["examplehost01", "examplehost02"].each do |hostname|
    config.vm.define hostname do |c|
      host_config = CONFIG_YML['hosts'][hostname]
      check_config(host_config, ['cpus', 'memory_mb', 'private_ip', 'ssh_forward_port'])

      c.vm.hostname = hostname
      c.vm.box = "bento/ubuntu-22.04"

      c.vm.provision "shell",
        inline: "nohup /vagrant/provision.sh >& /var/log/vm-provision.log &"

      c.vm.network "private_network", ip: host_config['private_ip']
      c.vm.network "forwarded_port", id: "ssh", guest: 22, host: host_config['ssh_forward_port']

      c.vm.provider "virtualbox" do |v|
        v.cpus = host_config['cpus']
        v.memory = host_config['memory_mb']
        v.customize ['modifyvm', :id, '--nictype1', 'virtio']

        # Additional disk
        vdi_path = "./disks/#{hostname}_sdb.vdi"
        if not File.exist?(vdi_path)
          v.customize ["createvdi", "--filename", vdi_path, "--size", 1024]
        end
        v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', vdi_path]
      end
    end
  end
end
