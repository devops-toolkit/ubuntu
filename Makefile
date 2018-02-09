BOX_VERSION ?= $(shell cat VERSION)
BOX_SUFFIX := -$(BOX_VERSION).box
BUILDER_TYPES ?= virtualbox
TEMPLATE_FILENAMES := $(filter-out ubuntu.json,$(wildcard *.json))
BOX_NAMES := $(basename $(TEMPLATE_FILENAMES))
BOX_FILENAMES := $(TEMPLATE_FILENAMES:.json=$(BOX_SUFFIX))
VIRTUALBOX_BOX_DIR ?= box/virtualbox
VIRTUALBOX_TEMPLATE_FILENAMES = $(TEMPLATE_FILENAMES)
VIRTUALBOX_BOX_FILENAMES := $(VIRTUALBOX_TEMPLATE_FILENAMES:.json=$(BOX_SUFFIX))
VIRTUALBOX_BOX_FILES := $(foreach box_filename, $(VIRTUALBOX_BOX_FILENAMES), $(VIRTUALBOX_BOX_DIR)/$(box_filename))
BOX_FILES := $(VIRTUALBOX_BOX_FILES)

box/virtualbox/%$(BOX_SUFFIX): %.json
	bin/box build $<

.PHONY: all clean assure deliver assure_atlas assure_atlas_virtualbox

all: build assure deliver

build: $(BOX_FILES)

assure: assure_virtualbox

assure_virtualbox: $(VIRTUALBOX_BOX_FILES)
	@for virtualbox_box_file in $(VIRTUALBOX_BOX_FILES) ; do \
		echo Checking $$virtualbox_box_file ; \
		bin/box test $$virtualbox_box_file virtualbox ; \
	done

assure_atlas: assure_atlas_virtualbox

assure_atlas_virtualbox:
	@for box_name in $(BOX_NAMES) ; do \
		echo Checking $$box_name ; \
		bin/test-vagrantcloud-box box-cutter/$$box_name virtualbox ; \
		bin/test-vagrantcloud-box boxcutter/$$box_name virtualbox ; \
	done

deliver:
	@for box_name in $(BOX_NAMES) ; do \
		echo Uploading $$box_name to Atlas ; \
		bin/register_atlas.sh $$box_name $(BOX_SUFFIX) $(BOX_VERSION) ; \
	done

clean:
	@for builder in $(BUILDER_TYPES) ; do \
		echo Deleting output-*-$$builder-iso ; \
		echo rm -rf output-*-$$builder-iso ; \
	done
	@for builder in $(BUILDER_TYPES) ; do \
		if test -d box/$$builder ; then \
			echo Deleting box/$$builder/*.box ; \
			find box/$$builder -maxdepth 1 -type f -name "*.box" ! -name .gitignore -exec rm '{}' \; ; \
		fi ; \
	done
