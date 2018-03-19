# Packer templates for Ubuntu and Debian

## Overview

This repository contains [Packer](https://packer.io/) templates for creating Ubuntu and Debian vagrant boxes.
This is a fork of [boxcutter/ubuntu](https://github.com/boxcutter/ubuntu) and
[boxcutter/debian](https://github.com/boxcutter/debian).  boxcutter stopped
to provide builded boxes in [October 2017](https://github.com/boxcutter/ubuntu/commit/d7c9ecbd525ec57b94be79ead388909a7cb7c7b4)
and it seems [they don't indent to do it anymore](https://github.com/boxcutter/ubuntu/issues/133).

The goal of this project is to provide a limited set of builded boxes.

Builded boxes can be found at [https://app.vagrantup.com/devops-toolkit](https://app.vagrantup.com/devops-toolkit).

## Scope of the project

Because the process of building and testing consumes a lot of time,
this project is limited in scope:

- virtualization software: VirtualBox only
- cpu architecture: amd64 only
- OS: Ubuntu and Debian
- no boxes with desktop enviroment

## Main differences with boxcutter/ubuntu

- added instructions to uploading builded boxes to vagrant cloud
- support for Parallels and VMware has been removed
- boxes with desktop environmet were removed
- outdated boxes were removed

## Building the Vagrant boxes with Packer

To build the boxes, you will need [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
installed.

We make use of JSON files containing user variables to build specific versions of Ubuntu.
You tell `packer` to use a specific user variable file via the `-var-file=` command line
option.  This will override the default options on the core `ubuntu.json` packer template,
which builds Ubuntu 16.04 by default.

For example, to build Ubuntu 16.04 box and upload it to [Vagrant Cloud](https://app.vagrantup.com/),
use the following commands:

```
export VAGRANT_CLOUD_USERNAME=username
export VAGRANT_CLOUD_ACCESS_TOKEN=token
packer build -var-file=ubuntu1604.json ubuntu.json
```

If you want to only build, but not upload, then:

```
jq '.["post-processors"][0] |= map(select(.type != "vagrant-cloud"))' ubuntu.json | packer build -var-file=ubuntu1604.json -
```

In the example above jq is used to remove postprocessor "vagrant-cloud" from the configuration file.
packer at the moment doesn't have a configuration option to skipt a preprocessor ([issue #2679](https://github.com/hashicorp/packer/issues/2679)).

### Proxy Settings

The templates respect the following network proxy environment variables
and forward them on to the virtual machine environment during the box creation
process, should you be using a proxy:

* http_proxy
* https_proxy
* ftp_proxy
* rsync_proxy
* no_proxy

### Variable overrides

There are several variables that can be used to override some of the default
settings in the box build process. The variables can that can be currently
used are:

* cpus
* disk_size
* memory
* update

The variable `HEADLESS` can be set to run Packer in headless mode.
Set `HEADLESS := true`, the default is false.

The variable `UPDATE` can be used to perform OS patch management.  The
default is to not apply OS updates by default.  When `UPDATE := true`,
the latest OS updates will be applied.

The variable `PACKER` can be used to set the path to the packer binary.
The default is `packer`.

The variable `ISO_PATH` can be used to set the path to a directory with
OS install images. This override is commonly used to speed up Packer builds
by pointing at pre-downloaded ISOs instead of using the default download
Internet URLs.

The variables `SSH_USERNAME` and `SSH_PASSWORD` can be used to change the
 default name & password from the default `vagrant`/`vagrant` respectively.

The variable `INSTALL_VAGRANT_KEY` can be set to turn off installation of the
default insecure vagrant key when the image is being used outside of vagrant.
Set `INSTALL_VAGRANT_KEY := false`, the default is true.

The variable `CUSTOM_SCRIPT` can be used to specify a custom script
to be executed. You can add it to the `script/custom` directory (content
is ignored by Git).
The default is `custom-script.sh` which does nothing.

## Acknowledgments

Original projects:
- [https://github.com/boxcutter/ubuntu](https://github.com/boxcutter/ubuntu)
- [https://github.com/boxcutter/debian](https://github.com/boxcutter/debian)
