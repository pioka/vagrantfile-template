# vagrantfile-template

## Usage
```
# clone repository
git clone https://github.com/pioka/vagrantfile-template.git
cd vagrantfile-template

# create `config.yml` from template
cp config.yml.default config.yml

# edit `config.yml`
vi config.yml

# create & start VM
vagrant up

# (optional) add ssh host configuration
vagrant ssh-config >> ~/.ssh/config
```
