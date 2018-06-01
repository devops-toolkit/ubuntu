# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  {
    "d8"                    => { image: "file://box/virtualbox/debian8-0.0.2.box" },
    "d9"                    => { image: "file://box/virtualbox/debian9-0.0.2.box" },
    "u1404"                 => { image: "file://box/virtualbox/ubuntu1404-0.0.2.box" },
    "u1604"                 => { image: "file://box/virtualbox/ubuntu1604-0.0.2.box" },
    "u1804"                 => { image: "file://box/virtualbox/ubuntu1804-0.0.4.box" },
  }.each do |short_name, params|
    config.vm.define short_name do |instance|
      instance.vm.box = params[:image]
      instance.vm.hostname = "#{short_name}"
    end
  end
end
