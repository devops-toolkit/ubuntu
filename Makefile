default:
	echo nothing

build-debian8:
	jq '.["post-processors"][0] |= map(select(.type != "vagrant-cloud"))' debian.json | packer build -var-file=debian8.json -

build-debian9:
	jq '.["post-processors"][0] |= map(select(.type != "vagrant-cloud"))' debian.json | packer build -var-file=debian9.json -

build-ubuntu1604:
	jq '.["post-processors"][0] |= map(select(.type != "vagrant-cloud"))' ubuntu.json | packer build -var-file=ubuntu1604.json -

build-ubuntu1804:
	jq '.["post-processors"][0] |= map(select(.type != "vagrant-cloud"))' ubuntu.json | packer build -var-file=ubuntu1804.json -

build-and-upload-debian8:
	packer build -var-file=debian8.json debian.json

build-and-upload-debian9:
	packer build -var-file=debian9.json debian.json

build-and-upload-ubuntu:
	$(MAKE) build-and-upload-ubuntu1604
	$(MAKE) build-and-upload-ubuntu1804

build-and-upload-ubuntu1604:
	packer build -var-file=ubuntu1604.json ubuntu.json

build-and-upload-ubuntu1804:
	packer build -var-file=ubuntu1804.json ubuntu.json
