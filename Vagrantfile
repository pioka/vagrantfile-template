require 'yaml'
require 'erb'

CONFIG_YML = YAML.load(
  ERB.new(File.read('config.yml')).result,
  aliases: true
)

def load_key(hostname, key)
  v = CONFIG_YML.dig('hosts', hostname, key)
  abort("`hosts.#{hostname}.#{key}` is not defined in config.yml") if v.nil?
  return v
end

Vagrant.configure("2") do |config|
  %w(examplehost01 examplehost02).each do |hostname|
    config.vm.define hostname do |c|
      c.vm.hostname = hostname
      c.vm.box = "bento/ubuntu-22.04"

      c.vm.provision "shell",
        inline: "nohup /vagrant/provision.sh >& /var/log/vm-provision.log &"

      c.vm.network "private_network",
        ip: load_key(hostname, 'private_ip')

      c.vm.network "forwarded_port",
        id: "ssh",
        guest: 22,
        host: load_key(hostname, 'ssh_forward_port')

      c.vm.provider "virtualbox" do |v|
        v.cpus = load_key(hostname, 'cpus')
        v.memory = load_key(hostname, 'memory_mb')
        v.customize [
          'modifyvm', :id,
          '--nictype1', 'virtio'
        ]

        ## Additional disk
        #vdi_path = "./disks/#{hostname}_sdb.vdi"
        #if not File.exist?(vdi_path)
        #  v.customize [
        #    "createvdi",
        #    "--filename", vdi_path,
        #    "--size", 1024
        #  ]
        #end
        #v.customize [
        #  'storageattach', :id,
        #  '--storagectl', 'SATA Controller',
        #  '--port', 1,
        #  '--device', 0,
        #  '--type', 'hdd',
        #  '--medium', vdi_path]
      end
    end
  end
end
