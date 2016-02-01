init:
	./bootstrap.sh

check:
	ansible-playbook -i  hosts site.yml --check --diff -c local --ask-sudo-pass

install:
	ansible-playbook -i hosts site.yml -c local --ask-sudo-pass

facts:
	ansible all -i hosts -m setup -c local --ask-sudo-pass
