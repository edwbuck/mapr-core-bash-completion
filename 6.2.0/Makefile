# Makefile for mapr-core-bash-completion
# Copyright 2023 Edwin Buck <edwbuck@gmail.com>
# Except as othewise noted, this file is licensed under the Apache 2.0 License.
# https://www.apache.org/licenses/LICENSE-2.0

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

DESTDIR=
PREFIX=/usr

CLEANUP_FILES=
DEFAULT_TARGETS=

.PHONY: all install uninstall

all:
	@echo "Call \"make install\" to install the mapr-core completions for your shell."
	@echo
	@echo "The following additional targets are available"
	@echo
	@echo "    make install_maprcli_bash       installs the maprcli bash completions"
	@echo "    make uninstall_maprcli_bash     installs the maprcli bash completions"

BASH_COMPLETIONS_DIR := $(shell pkg-config --variable=completionsdir bash-completion)
ifeq ($(BASH_COMPLETIONS_DIR),)
$(error Bash completions dir cannot be detected)
endif

# bash_completion rules
DEFAULT_TARGETS+=maprcli_bash

install_maprcli_bash:
	install -D -m 644 $(current_dir)/bash_completion/maprcli ${DESTDIR}${BASH_COMPLETIONS_DIR}/maprcli

uninstall_maprcli_completion:
	rm -f ${DESTDIR}${BASH_COMPLETIONS_DIR}/maprcli


# Manpage rules
DEFAULT_TARGETS+=manpage

MAN1:=${DESTDIR}${PREFIX}/share/man/man1

install_manpage:
	mkdir -p ${MAN1}
	cp man1/maprcli.1 ${MAN1}
	cp man1/maprcli_acerole.1 ${MAN1}

uninstall_manpage:
	rm -f ${MAN1}/maprcli.1
	rm -f ${MAN1}/maprcli_acerole.1

# Install dependencies
TARGETS=$(DEFAULT_TARGETS)
install: $(patsubst %,install_%,$(TARGETS))
uninstall: $(patsubst %,uninstall_%,$(TARGETS))

ifeq ($(CLEANUP_FILES),)
clean:
	@echo no files to remove
else
clean:
	rm -rf $(CLEANUP_FILES)
endif


