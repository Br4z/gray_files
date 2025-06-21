#!/bin/bash


if [ -f "/usr/share/nvm/init-nvm.sh" ]; then
 	source "/usr/share/nvm/init-nvm.sh"
fi

if [ -d "$HOME/.spicetify" ]; then
 	export PATH="$HOME/.spicetify:$PATH"
fi

export _JAVA_AWT_WM_NONREPARENTING=1
export PATH="$HOME/.local/bin":"$PATH"
