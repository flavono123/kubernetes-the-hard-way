Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_version = "20220215.1.0"
  
  config.vm.define "cluster1-master1" do |master|
    master.vm.provider "virtualbox" do |vbox|
      vbox.name = "cluster1-master1"
      vbox.cpus = 2
      vbox.memory = 2048
    end
    
    master.vm.hostname = "cluster1-master1"
    master.vm.network :private_network, ip: "192.168.1.1"
    master.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh"  
  end

  config.vm.define "cluster1-worker1" do |worker|
    worker.vm.provider "virtualbox" do |vbox|
      vbox.name = "cluster1-worker1"
      vbox.cpus = 1
      vbox.memory = 1024
    end
    
    worker.vm.hostname = "cluster1-worker1"
    worker.vm.network :private_network, ip: "192.168.1.2"
    worker.vm.network :forwarded_port, guest: 22, host: 2223, id: "ssh"  
  end

  config.vm.define "cluster1-worker2" do |worker|
    worker.vm.provider "virtualbox" do |vbox|
      vbox.name = "cluster1-worker2"
      vbox.cpus = 1
      vbox.memory = 1024
    end
    
    worker.vm.hostname = "cluster1-worker2"
    worker.vm.network :private_network, ip: "192.168.1.3"
    worker.vm.network :forwarded_port, guest: 22, host: 2224, id: "ssh"  

    # All VMs are up, after cluster1-worker2 is up, provisioning the entire VMs at once
    worker.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/cluster-nodes.yaml"
      ansible.inventory_path = "provisioning/cluster1-nodes"
      ansible.limit = "all"
    end
  end
end
