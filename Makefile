default:
	echo nothing

build-and-upload-ubuntu1404:
	packer build -var-file=ubuntu1404.json ubuntu.json

build-and-upload-ubuntu1404-desktop:
	packer build -var-file=ubuntu1404-desktop.json ubuntu.json

build-and-upload-ubuntu1604:
	packer build -var-file=ubuntu1604.json ubuntu.json

build-and-upload-ubuntu1604-desktop:
	packer build -var-file=ubuntu1604-desktop.json ubuntu.json
