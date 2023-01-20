# Makefile for mapr-core-bash-completion
# Copyright 2023 Edwin Buck <edwbuck@gmail.com>
# Except as othewise noted, this file is licensed under the Apache 2.0 License.
# https://www.apache.org/licenses/LICENSE-2.0
#
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

DESTDIR=/
PREFIX=/usr/
RPMS=el8-6.2.0 el8-7.0.0

DEFAULT_TARGETS=
CLEANUP_FILES=

.PHONY: all install uninstall mapr_core_bash_completion 

all:
	@echo "Call \"make install\" to install the mapr-core-bash-completion software."
	@echo
	@echo "The following additional targets are available"
	@echo
	@echo "    make rpm                 creates the Source RPM packages"

BASH_COMPLETIONS_DIR:=$(shell pkg-config --variable=completiondir bash-completion 2>/dev/null)
ifneq (,$(BASH_COMPLETIONS_DIR))
$(error Bash completions dir cannot be detected)
endif


install_maprcli:
	install -D -m 644 contrib/bash_completion/maprcli ${DESTDIR}/${BASH_COMPLETIONS_DIR}/maprcli

uninstall_maprcli:
	rm -f ${DESTDIR}/${BASH_COMPLETIONS_DIR}/maprcli


# Manpage rules
DEFAULT_TARGETS+=manpage

MANDIR:=${PREFIX}/share/man/man1

install_manpage:
	mkdir -p ${DESTDIR}/${MANDIR}
	cp maprcli.1 ${DESTDIR}/${MANDIR}

uninstall_manpage:
	rm -f ${DESTDIR}/${MANDIR}/maprcli.1

TARGETS=$(DEFAULT_TARGETS)

install: $(patsubst %,install_%,%(TARGETS))
uninstall: $(patsubst %,uninstall_%,$(TARGETS))

# RPM packaging rules
define mapr_source_dir
$(current_dir)/$(word 2,$(subst -, ,$1))
endef

define mapr_version
$(notdir $(call mapr_source_dir,$1))
endef

define rpm_build_root
$(current_dir)/rpmbuild-$1
endef

define rpm_tgz_file
$(call rpm_build_root,$1)/SOURCES/mapr-core-bash-completion-$(word 2,$(subst -, ,$1)).tgz
endef

define rpm_spec_source_file
$(current_dir)/$(word 1,$(subst -, ,$1))/mapr-core-bash-completion.spec.tmpl
endef

define rpm_spec_file
$(current_dir)/rpmbuild-$1/SPECS/mapr-core-bash-completion.spec
endef

CLEANUP_FILES+=$(patsubst %,rpmbuild-%,$(RPMS)) mapr-core-bash-completion-*.src.rpm

rpm: $(RPMS)

$(RPMS): 
	@echo building \'mapr-core-bash-completion-$@\'
	mkdir -p $(dir $(call rpm_tgz_file,$@))
	tar --transform "s/^\./mapr-core-bash-completion-$(call mapr_version,$@)/" -c -f $(call rpm_tgz_file,$@) -C $(call mapr_source_dir,$@) .
	@mkdir -p $(dir $(call rpm_spec_file,$@))
	@cp $(call rpm_spec_source_file,$@) $(call rpm_spec_file,$@)
	sed -i -e "s/__VERSION__/$(call mapr_version,$@)/g" $(call rpm_spec_file,$@) 
	@rpmbuild -bs --define="_topdir $(call rpm_build_root,$@)" $(call rpm_spec_file,$@) >/dev/null
	@cp $(call rpm_build_root,$@)/SRPMS/*.src.rpm $(current_dir)

ifeq ($(CLEANUP_FILES),)
clean:
	@echo no files to remove
else
clean:
	rm -rf $(CLEANUP_FILES)
endif


