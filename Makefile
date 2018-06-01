default:
	echo nothing

build-debian8:
	jq '.["post-processors"][0] |= map(select(.type != "vagrant-cloud"))' debian.json | packer build -var-file=debian8.json -

build-debian9:
	jq '.["post-processors"][0] |= map(select(.type != "vagrant-cloud"))' debian.json | packer build -var-file=debian9.json -

build-ubuntu1404:
	jq '.["post-processors"][0] |= map(select(.type != "vagrant-cloud"))' ubuntu.json | packer build -var-file=ubuntu1404.json -

build-ubuntu1604:
	jq '.["post-processors"][0] |= map(select(.type != "vagrant-cloud"))' ubuntu.json | packer build -var-file=ubuntu1604.json -

build-ubuntu1804:
	jq '.["post-processors"][0] |= map(select(.type != "vagrant-cloud"))' ubuntu.json | packer build -var-file=ubuntu1804.json -

build-and-upload-debian8:
	packer build -var-file=debian8.json debian.json

build-and-upload-debian9:
	packer build -var-file=debian9.json debian.json

build-and-upload-ubuntu:
	$(MAKE) build-and-upload-ubuntu1404
	$(MAKE) build-and-upload-ubuntu1604
	$(MAKE) build-and-upload-ubuntu1804

build-and-upload-ubuntu1404:
	packer build -var-file=ubuntu1404.json ubuntu.json

build-and-upload-ubuntu1604:
	packer build -var-file=ubuntu1604.json ubuntu.json

build-and-upload-ubuntu1804:
	packer build -var-file=ubuntu1804.json ubuntu.json

download-images:
	cd iso && wget --continue http://releases.ubuntu.com/14.04/ubuntu-14.04.5-server-amd64.iso
	cd iso && wget --continue http://releases.ubuntu.com/16.04/ubuntu-16.04.4-server-amd64.iso
	cd iso && wget --continue http://cdimage.ubuntu.com/ubuntu/releases/bionic/release/ubuntu-18.04-server-amd64.iso
	cd iso && wget --continue https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.4.0-amd64-netinst.iso
	cd iso && wget --continue https://cdimage.debian.org/mirror/cdimage/archive/8.10.0/amd64/iso-cd/debian-8.10.0-amd64-netinst.iso
