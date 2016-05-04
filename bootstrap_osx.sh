#!/bin/bash

which -s brew
if [[ $? !=  0 ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update && brew upgrade
    
    brew doctor
    
    if [[ $? != 0 ]]; then
        echo "There is something wrong with homebrew. Please check the errors and fix them before continuing."
        echo "$(!!)"
        exit 1
    fi
fi

sudo easy_install pip
sudo pip install --upgrade paramiko PyYAML Jinja2 httplib2 six

brew install git
