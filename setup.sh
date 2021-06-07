#!/bin/bash
mkdir -p $HOME/.vim
mkdir -p $HOME/.config/i3
dotFileDir=$(pwd)
unameS=$(uname -s)

function dotfilelink {
    dest="$HOME/$2"
    echo "The destination is " $dest
    if [ -d $dest ]; then
        echo "Removing folder existing symlink"
        rm $dest
    fi
    if [ -f $dest ]; then
        echo "Removing file symlink"
        rm $dest
    fi
    if [ -h $dest ]; then
        echo "Removing symlink"
        rm $dest
    fi
    echo "Creating symlink"
    ln -s $dotFileDir/$1 $dest
}

function linkAllFiles {
    dotfilelink vim/vimrc .vim/vimrc
    dotfilelink vim/UltiSnips .vim/UltiSnips

    dotfilelink gitconfig .gitconfig
    dotfilelink inputrc .inputrc

    dotfilelink config/polybar .config/polybar
    dotfilelink config/zathura .config/zathura
    dotfilelink i3/desk-config .config/i3/config

    dotfilelink zsh/zshrc .zshrc
    dotfilelink config/Xresources .Xresources
}

if [ "$1" = "relink" ]; then
    linkAllFiles
    exit
fi

packages="neovim nodejs npm neofetch fzf tree lua ripgrep"
if [ $unameS = "Linux" ]; then
    linkAllFiles
    sudo pacman -S --needed $packages fortune-mod
fi

vim +PlugInstall +q! +q! +q!
sudo npm i -g bash-language-server
