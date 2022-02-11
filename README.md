# vagrantfile-template
個人用Vagrantfileテンプレ

## Usage
```
# clone repository
git clone https://github.com/pioka/vagrantfile-template.git 02-example
cd 02-example

# generate config from template
cp config.rb.default config.rb

# edit config
vi config.rb

# start VM
vagrant up

# (optional) add ssh host configuration
vagrant ssh-config >> ~/.ssh/config
```
