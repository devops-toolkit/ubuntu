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

```
make build-ubuntu1804
```

If you want not only build, but also upload to vagrant cloud:

```
export VAGRANT_CLOUD_USERNAME=username
export VAGRANT_CLOUD_ACCESS_TOKEN=token
make build-and-upload-ubuntu1804
```

## Acknowledgments

Original projects:
- [https://github.com/boxcutter/ubuntu](https://github.com/boxcutter/ubuntu)
- [https://github.com/boxcutter/debian](https://github.com/boxcutter/debian)
