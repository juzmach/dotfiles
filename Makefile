# Check OS

UNAME := $(shell uname -s)
ifeq ($(UNAME),Darwin)
	PLAYBOOK := ./playbooks/osx.yml
else
	PLAYBOOK := ./playbooks/linux.yml
endif


init:
	./bootstrap.sh

check:
	ansible-playbook $(PLAYBOOK) --check --diff -c local --ask-sudo-pass

install:
	ansible-playbook $(PLAYBOOK) -c local --ask-sudo-pass --skip-tags "upgrade"

upgrade:
	ansible-playbook $(PLAYBOOK) -c local --ask-sudo-pass --tags "upgrade"

facts:
	ansible all -m setup -c local --ask-sudo-pass
