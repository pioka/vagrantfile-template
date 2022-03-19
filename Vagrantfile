require 'yaml'
require 'erb'

if not File.file?("config.yml")
  abort("file `config.yml` does not exist")
end
config_yml = YAML.load(ERB.new(File.read('config.yml')).result)

Vagrant.configure("2") do |config|
  config.vm.define 'examplehost01' do |c|
    hostname = 'examplehost01'
    host_config = config_yml['hosts'][hostname]

    abort("#{hostname} is not defined in config.yml") if host_config.nil?
    required_keys = ['cpus', 'memory_mb', 'private_ip', 'ssh_forward_port']
    required_keys.each do |k|
      abort("#{hostname} #{k} not defined") if not host_config.has_key?(k)
    end

    c.vm.hostname = hostname
    c.vm.box = "bento/ubuntu-20.04"
    c.vm.provision "shell", path: "./provision.sh"
    c.vm.network "private_network", ip: host_config['private_ip']
    c.vm.network "forwarded_port", id: "ssh", guest: 22, host: host_config['ssh_forward_port']

    c.vm.provider "virtualbox" do |v|
      v.cpus = host_config['cpus']
      v.memory = host_config['memory_mb']

#      vdi_path = "./disks/#{hostname}_sdb.vdi"
#      if not File.exist?(vdi_path)
#        v.customize ["createvdi", "--filename", vdi_path, "--size", 1024]
#      end
#      v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', vdi_path]
    end
  end
end
