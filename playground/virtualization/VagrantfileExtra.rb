# -*- mode: ruby -*-
# vi: set ft=ruby :

# This file should allow you to edit Vagrant related options Feel free
# to modify it to avoid having your own project dependent Vagrantfile.
# If the provided possibilities are not enough for you, please get in
# touch so we can find a common solution !

require 'yaml'

class CustomConfig
  # Those accessors will be used by the Vagrantfile
  attr_accessor :project_name
  attr_accessor :hostname
  attr_accessor :hostnames
  attr_accessor :box_ip
  attr_accessor :playbook

  attr_accessor :vbox_box_name
  attr_accessor :vbox_box_url
  attr_accessor :lxc_box_url
  attr_accessor :lxc_box_name

  # Retrieve the values of 'virtualization/parameters.yml' so that
  # they can be used by Vagrant. If you need to change those values
  # prefer editing the parameters.yml file instead.
  def initialize
    parameters_file = ENV.fetch('VIRTUALIZATION_PARAMETERS_FILE', 'virtualization/parameters.yml')
    config = YAML::load(File.open(parameters_file))

    @project_name = config['project_name'] || "rawbot"
    @hostname = config['hostname'] || "#{@project_name}.lo"
    @hostnames = config['hostnames'] || Array.new
    @box_ip = config['box_ip'] || "10.10.10.10"
    @playbook = config['playbook'] || "virtualization/playbook.yml"

    @vbox_box_url = "http://vagrantbox-public.liip.ch/liip-wheezy64.box"
    @vbox_box_name = "wheezy64"
    @lxc_box_url = "http://vagrantbox-public.liip.ch/liip-wheezy64-lxc.box"
    @lxc_box_name = "wheezy64-lxc"
  end

  # Modify this if you need to determine a list from hostnames
  # from a file for example.
  def load_aliases
    @hostnames
  end
end
