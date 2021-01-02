#!/bin/bash
# This is a minimal script to setup a new environment

# Ensure you are in the right place
if ! grep -q 'claudiodangelis/dotfiles' .git/config > /dev/null 2>&1; then
    echo "This script must be run from the claudiodangelis/dotfiles repository"
    exit 1
fi

# Take a backup of the files you are going to work with
BACKUPDIR=backups/$(date +%s)
mkdir -p $BACKUPDIR
cp ~/.bashrc ~/.dotfiles ~/.env ~/.aliases $BACKUPDIR
echo "- backup taken: $BACKUPDIR"

# Install dotfiles
cp .dotfiles .functions .aliases .env ~
echo "- dotfiles installed"

# Install dependencies and tools
# z.sh
# hstr

# Install custom binaries and script
echo "installing custom binary and scripts..."
mkdir -p $BACKUPDIR/bin
mkdir -p ~/bin
cd bin
for f in *
do
    if [[ -f ~/bin/$f ]]; then
        echo "- taking backup of ~/bin/$f"
        cp -f ~/bin/$f $BACKUPDIR/bin
    fi
    echo "- installing ~/bin/$f"
    cp $f ~/bin/$f
done
cd -
echo "- custom binaries and script installed"