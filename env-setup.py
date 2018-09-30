#! /usr/bin/env python

import os
from os import path
import platform


SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
HOME_DIR = path.expanduser("~")
PLATFORM = platform.system()

def create_directories():
    os.makedirs(path.join(HOME_DIR, ".vim/undo"))

def create_symlinks():
    os.symlink(path.join(SCRIPT_DIR, 'gitconfig'), path.join(HOME_DIR, '.gitconfig'))
    os.symlink(path.join(SCRIPT_DIR, 'bashrc'), path.join(HOME_DIR, '.bashrc'))
    os.symlink(path.join(SCRIPT_DIR, 'vimrc'), path.join(HOME_DIR, '.vimrc'))
    os.symlink(path.join(SCRIPT_DIR, 'tmux.conf'), path.join(HOME_DIR, '.tmux.conf'))
    os.symlink(path.join(SCRIPT_DIR, 'gitignore_global'), path.join(HOME_DIR, '.gitignore_global'))
    os.symlink(path.join(SCRIPT_DIR, 'editorconfig'), path.join(HOME_DIR, '.editorconfig'))

def install_brew():
    if not os.system('brew help'):
        os.system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')


def install_packages():
    packages = '''
    macvim
    caskroom/fonts/font-meslo-for-powerline
    python3
    bash-completion
    maven-completion
    direnv
    caffeine
    jenv
    fzf
    maven
    ack
    google-chrome
    bat
    pretty-ping
    '''

    os.system('brew install ' + packages)

def main():
    create_symlinks()
    # install_brew()
    # install_brew_packages()


if __name__ == '__main__':
    main()
