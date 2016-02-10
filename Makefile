init:
	./bootstrap.sh

check:
	ansible-playbook -i  hosts site.yml --check --diff -c local --ask-sudo-pass

install:
	ansible-playbook -i hosts site.yml -c local --ask-sudo-pass --skip-tags "upgrade"

upgrade:
	ansible-playbook -i hosts site.yml -c local --ask-sudo-pass --tags "upgrade"

facts:
	ansible all -i hosts -m setup -c local --ask-sudo-pass
