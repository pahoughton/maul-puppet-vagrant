# 2018-12-23 (cc) <paul4hough@gmail.com>
#

Vagrant.configure("2") do |config|
  # config.vm.box_check_update = false

  maul = 'maul'
  config.vm.define maul do |bcfg|
    bcfg.vm.box = "c7g-puppet"

    bcfg.vm.hostname    = maul
    bcfg.vm.network    'private_network', ip: '10.0.7.5'
    bcfg.vm.provider   'virtualbox' do |vb|
      vb.name      = maul
      vb.cpus      = 2
      vb.memory    = 4096
      vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
      vb.customize ['modifyvm', :id, '--natdnspassdomain1', 'on']
      vb.customize ['modifyvm', :id, '--usb', 'off']
      # second drive for lvm
      sdb = "maul-sdb.vdi"
      unless File.exist?(sdb)
        vb.customize ['createhd',
                      '--filename',sdb,
                      '--size',20 * 1024]
      end
      vb.customize ['storageattach', :id,
                    '--storagectl', 'IDE',
                    '--port', 0, '--device', 1,
                    '--type', 'hdd',
                    '--medium', sdb]
    end
    bcfg.vm.provision "puppet" do |puppet|
      puppet.options        = '--verbose' # '--debug'
      puppet.manifests_path = ['vm','/vagrant/puppet']
      puppet.manifest_file  = 'maul.pp'
      puppet.module_path    = 'puppet/modules'
      puppet.facter         = {
        'maul_consul_retry'     => ['10.0.7.6',
                                    '10.0.7.8',],
        'maul_firewall_zone'    => 'public',
        'maul_datacenter'       => 'dc-maul',
        'maul_servertype'       => 'maul',
        'maul_mongrp'           => 'a-1',
        'maul_prom_mongrp'      => 'a-1',
        'maul_agate_node'       => '10.0.7.5',
        'maul_vg_dev'           => '/dev/sdb',

        'maul_alert_agate'        => true,
        'maul_alert_alertmanager' => true,
        'maul_alert_cloudera'     => true,
        'maul_alert_consul'       => true,
        'maul_alert_grafana'      => true,
        'maul_alert_hpsm'         => true,
        'maul_alert_sysd'         => true,
        'maul_alert_sysv'         => true,
      }
    end
  end

  csrv = 'csrv'
  config.vm.define csrv do |bcfg|
    bcfg.vm.box = "c7g-puppet"

    bcfg.vm.hostname    = csrv
    bcfg.vm.network    'private_network', ip: '10.0.7.6'
    bcfg.vm.provider   'virtualbox' do |vb|
      vb.name      = csrv
      vb.cpus      = 1
      vb.memory    = 2048
      vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
      vb.customize ['modifyvm', :id, '--natdnspassdomain1', 'on']
      vb.customize ['modifyvm', :id, '--usb', 'off']
      sdb = "csrv-sdb.vdi"
      unless File.exist?(sdb)
        vb.customize ['createhd',
                      '--filename',sdb,
                      '--size',20 * 1024]
      end
      vb.customize ['storageattach', :id,
                    '--storagectl', 'IDE',
                    '--port', 0, '--device', 1,
                    '--type', 'hdd',
                    '--medium', sdb]
    end
    bcfg.vm.provision "puppet" do |puppet|
      puppet.options        = '--verbose' # '--debug'
      puppet.manifests_path = ['vm','/vagrant/puppet']
      puppet.manifest_file  = 'consul-server.pp'
      puppet.module_path    = 'puppet/modules'
      puppet.facter         = {
        'maul_consul_retry'     => ['10.0.7.6',
                                    '10.0.7.7',],
        'maul_firewall_zone'    => 'public',
        'maul_datacenter'       => 'dc-maul',
        'maul_servertype'       => 'maul',
        'maul_mongrp'           => 'a-1',
        'maul_vg_dev'           => '/dev/sdb',
      }
    end
  end

  pgsql = 'pgsql'
  config.vm.define pgsql do |bcfg|
    bcfg.vm.box = "c7g-puppet"

    bcfg.vm.hostname    = pgsql
    bcfg.vm.network    'private_network', ip: '10.0.7.7'
    bcfg.vm.provider   'virtualbox' do |vb|
      vb.name      = pgsql
      vb.cpus      = 1
      vb.memory    = 2048
      vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
      vb.customize ['modifyvm', :id, '--natdnspassdomain1', 'on']
      vb.customize ['modifyvm', :id, '--usb', 'off']
      sdb = "pgsql-sdb.vdi"
      unless File.exist?(sdb)
        vb.customize ['createhd',
                      '--filename',sdb,
                      '--size',20 * 1024]
      end
      vb.customize ['storageattach', :id,
                    '--storagectl', 'IDE',
                    '--port', 0, '--device', 1,
                    '--type', 'hdd',
                    '--medium', sdb]
    end
    bcfg.vm.provision "puppet" do |puppet|
      puppet.options        = '--verbose' # '--debug'
      puppet.manifests_path = ['vm','/vagrant/puppet']
      puppet.manifest_file  = 'consul-server-postgres.pp'
      puppet.module_path    = 'puppet/modules'
      puppet.facter         = {
        'maul_consul_retry'     => ['10.0.7.6',
                                    '10.0.7.7',],
        'maul_firewall_zone'    => 'public',
        'maul_datacenter'       => 'dc-maul',
        'maul_servertype'       => 'maul',
        'maul_mongrp'           => 'a-1',
        'maul_vg_dev'           => '/dev/sdb',
      }
    end
  end
end
