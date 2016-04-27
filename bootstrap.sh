#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    echo "Running OS X!"
    echo "Checking if Homebrew is installed.."
    which -s brew
    if [[ $? != 0 ]]; then
        echo "Nope. Installing Homebrew.."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "Homebrew is installed. Updating cache and upgrading packages.."
        brew update && brew upgrade

        echo "Checking what the doctor says about homebrew."
        brew doctor
        if [[ $? != 0 ]]; then
            echo "There is something wrong with it. Please check the errors and fix them before continuing."
            echo "$(!!)"
        else
            echo "Everything's in order! Moving on."
        fi
    fi
elif [ "$(uname)" == "Linux" ]; then
    echo "Running Linux!"
    echo "Installing Python setuptools"
    sudo apt-get -y install python-setuptools 
fi

which pip
if [[ $? != 0 ]]; then
    echo "Installing pip"
    sudo easy_install pip
fi

echo "Installing Ansible's dependencies"
sudo pip install --upgrade paramiko PyYAML Jinja2 httplib2 six

echo "Installing Ansible"

ansible_location="$HOME/.ansible_runtime"

if [ -d $ansible_location ]; then
    echo "Ansible already installed"
else
    which git
    if [[ $? != 0 ]]; then
        echo "git not installed. Installing it first."
        brew install git
        echo "Now we can install Ansible!"
    fi

    git clone git://github.com/ansible/ansible.git  $ansible_location --recursive
    echo "Cloned Ansible repository to $ansible_location"
fi

source_string="source $ansible_location/hacking/env-setup -q"
aliases_file="$HOME/.aliases"

if [ ! -f $aliases_file ]; then
    echo "# Aliases" >> $aliases_file
    echo "alias ansinit=\"$source_string\"" >> $aliases_file
fi
