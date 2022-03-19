# vagrantfile-template
個人用Vagrantfileテンプレ

## Usage
```
# clone repository
git clone https://github.com/pioka/vagrantfile-template.git 02-example
cd 02-example

# generate config from template
cp config.yml.default config.yml

# edit config
vi config.yml

# start VM
vagrant up

# (optional) add ssh host configuration
vagrant ssh-config >> ~/.ssh/config
```

## tips
ディレクトリ名からIP,SSHポートを決定する

```erb
<% index = File.basename(Dir.getwd).match(/^\d\d/)[0].to_i %>

hosts:
  examplehost01:
    cpus: 1
    memory_mb: 512
    private_ip: 192.168.222.<%= index %>
    ssh_forward_port: <%= 22200 + index %>
  examplehost02:
    <% index += 1 %>
    cpus: 1
    memory_mb: 512
    private_ip: 192.168.222.<%= index %>
    ssh_forward_port: <%= 22200 + index %>
```