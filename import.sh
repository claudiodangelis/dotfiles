#!/bin/bash
cp ~/.bash_profile .
cp ~/.xinitrc .
if [[ ! -d openbox ]]; then
    mkdir openbox
fi
cp ~/.config/openbox/autostart openbox
cp ~/.config/openbox/rc.xml openbox
if [[ ! -d sublime-text-3 ]]; then
    mkdir sublime-text-3
fi
cp -r ~/.config/sublime-text-3/Packages/User sublime-text-3