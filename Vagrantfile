# frozen_string_literal: true

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/focal64'
  config.vm.box_version = '20220215.1.0'

  config.vm.define 'node-1' do |master|
    master.vm.provider 'virtualbox' do |vbox|
      vbox.name = 'node-1'
      vbox.cpus = 2
      vbox.memory = 2048
    end

    master.vm.hostname = 'node-1'
    master.vm.network :private_network, ip: '192.168.1.2',
      virtualbox__intnet: true
    master.vm.network :forwarded_port, guest: 22, host: 2222, id: 'ssh'
    # K8s NodPort ranges
    (30_000..32_767).each do |port|
      master.vm.network :forwarded_port, guest: port, host: port
    end
  end

  config.vm.define 'node-2' do |worker|
    worker.vm.provider 'virtualbox' do |vbox|
      vbox.name = 'node-2'
      vbox.cpus = 2
      vbox.memory = 3072
    end

    worker.vm.hostname = 'node-2'
    worker.vm.network :private_network, ip: '192.168.1.3',
      virtualbox__intnet: true
    worker.vm.network :forwarded_port, guest: 22, host: 2223, id: 'ssh'
  end

  config.vm.define 'node-3' do |worker|
    worker.vm.provider 'virtualbox' do |vbox|
      vbox.name = 'node-3'
      vbox.cpus = 2
      vbox.memory = 3072
    end

    worker.vm.hostname = 'node-3'
    worker.vm.network :private_network, ip: '192.168.1.4',
      virtualbox__intnet: true
    worker.vm.network :forwarded_port, guest: 22, host: 2224, id: 'ssh'

    # All VMs are up, after node-3 is up, provisioning the entire VMs at once
    worker.vm.provision 'ansible' do |ansible|
      ansible.playbook = 'provisioning/cluster.yaml'
      ansible.inventory_path = 'provisioning/k8s'
      ansible.limit = 'all'
    end
  end
end
