#!/bin/bash
#  ______   ______   ______   __  __   ______   ______
# /\  == \ /\  __ \ /\  ___\ /\ \_\ \ /\  == \ /\  ___\
# \ \  __< \ \  __ \\ \___  \\ \  __ \\ \  __< \ \ \____
#  \ \_____\\ \_\ \_\\/\_____\\ \_\ \_\\ \_\ \_\\ \_____\
#   \/_____/ \/_/\/_/ \/_____/ \/_/\/_/ \/_/ /_/ \/_____/


[[ $- != *i* ]] && return # Exit if the current shell is not interactive

# ---------------------------------------------------------------------------- #
#                                 SOURCE FILES                                 #
# ---------------------------------------------------------------------------- #

if [ -f "$HOME/.bash_utilities" ]; then
	source "$HOME/.bash_utilities"
fi

if [ -f "$HOME/.bash_profile" ]; then
	source "$HOME/.bash_profile"
fi

# ---------------------------------------------------------------------------- #
#                                    PROMPT                                    #
# ---------------------------------------------------------------------------- #

if which oh-my-posh &>/dev/null; then
	theme_path=""

	if [ "$POSH_THEMES_PATH" ]; then
		theme_path="$POSH_THEMES_PATH/kali.omp.json"
	else
		theme_path="~/.oh_my_posh-theme.json"
	fi

	eval "$(oh-my-posh init bash --config "$theme_path")"
fi
