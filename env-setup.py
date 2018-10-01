#! /usr/bin/env python

import os
from os import path
import platform
from subprocess import call


SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
HOME_DIR = path.expanduser("~")
PLATFORM = platform.system()


def install_tmux_tpm():
    if not path.exists("~/.tmux/plugins/tpm"):
        print("Installing tmux tpm plugin manager")
        call("git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm".split())


def create_directories():
    os.makedirs(path.join(HOME_DIR, ".vim/undo"))


def install_file(src, dst):
    if path.exists(dst):
        if path.islink(dst):
            print("File {} exists and is a symbolic link. Unlinking...".format(dst))
            os.unlink(dst)
        elif not filecmp.cmp(src, dst):
            backup_file = dst + ".bkp"
            print("File {} exists, creating backup at: {}".format(dst, backup_file))
            os.rename(dst, backup_file)
        elif filecmp.cmp(src, dst):
            print("File {} exists and have the same content as the file to be installed. Removing...".format(dst))
            os.remove(dst)

    os.symlink(src, dst)


def install_files():
    install_file(path.join(SCRIPT_DIR, 'gitconfig'), path.join(HOME_DIR, '.gitconfig'))
    install_file(path.join(SCRIPT_DIR, 'bashrc'), path.join(HOME_DIR, '.bashrc'))
    install_file(path.join(SCRIPT_DIR, 'vimrc'), path.join(HOME_DIR, '.vimrc'))
    install_file(path.join(SCRIPT_DIR, 'tmux.conf'), path.join(HOME_DIR, '.tmux.conf'))
    install_file(path.join(SCRIPT_DIR, 'gitignore_global'), path.join(HOME_DIR, '.gitignore_global'))
    install_file(path.join(SCRIPT_DIR, 'editorconfig'), path.join(HOME_DIR, '.editorconfig'))


def install_homebrew():
    if not os.system('brew help'):
        os.system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')


def install_mac_packages():
    packages = '''
    ack
    bash-completion
    bat
    diff-so-fancy
    direnv
    fd
    fpp
    fzf
    git-cola
    httpie
    jenv
    maven
    maven-completion
    midnight-commander
    prettyping
    python
    macvim
    tmux
    tree
    watch
    caskroom/fonts/font-meslo-for-powerline
    '''

    print("Installing brew packages: {}".format(packages))
    os.system('brew install ' + packages)

    cask_packages = '''
    caffeine
    google-chrome
    java
    kdiff3
    macdown
    macvim
    wireshark
    '''
    print("Installing brew cask packages: {}".format(cask_packages))
    os.system('brew cask install ' + cask_packages)


def main():
    install_files()
    install_tmux_tpm()

    if PLATFORM == "Darwin":
        install_homebrew()
        install_mac_packages()


if __name__ == '__main__':
    main()
