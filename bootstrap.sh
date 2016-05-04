#!/bin/bash

# Functions

check_homebrew() {
    echo "Checking if Homebrew is installed.."
    which -s brew
    
    if [[ $? != 0 ]]; then
        echo "Nope. Installing Homebrew.."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"   
    else
        echo "Homebrew is installed!"
    fi

    echo "Updating brew.."
    brew update && brew upgrade

    echo "Checking what the doctor says about homebrew.."
    brew doctor
    
    if [[ $? != 0 ]]; then
        echo "There is something wrong with it. Please check the errors and fix them before continuing."
        exit 1
    else
        echo "Everything's in order! Moving on.."
    fi
}

check_os() {
    if [[ "$(uname)" == "Darwin"  ]]; then
        echo "Running OS X"
        os=osx
    elif [[ "$(uname)" == "Linux" ]]; then
        echo "Running Linux!"
        os=linux
    else
        echo "Could not detect OS."
        exit 1
    fi
}

# Main

check_os

case $os in
    osx)
        check_homebrew
        ;;
    linux)
        sudo apt-get update && sudo apt-get -y upgrade
        sudo apt-get -y install python-setuptools python-dev libffi-dev libssl-dev
        ;;
    *)
        echo "No OS set. Nothing to do."
        exit 1
        ;;
esac

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
        if [[ $os == "osx" ]]; then
            brew install git
        else
            sudo apt-get -y install git
        fi
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
