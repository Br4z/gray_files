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

if [[ -f "$HOME/.bash_utilities" ]]; then
	source "$HOME/.bash_utilities"
fi

# ---------------------------------------------------------------------------- #
#                                    PROMPT                                    #
# ---------------------------------------------------------------------------- #

# if command_exists oh-my-posh; then
# 	theme_path=""

# 	if [ "$POSH_THEMES_PATH" ]; then
# 		theme_path="$POSH_THEMES_PATH/kali.omp.json"
# 	else
# 		theme_path="$HOME/.oh_my_posh-theme.json"
# 	fi

# 	eval "$(oh-my-posh init bash --config "$theme_path")"
# fi

# Optimized git branch parsing with error handling
parse_git_branch() {
	local branch
	if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then # Try regular branch first
		echo "$branch"
	elif branch=$(git describe --exact-match HEAD 2>/dev/null); then # Try any tag/description for detached HEAD
		echo "$branch"
	fi
}

# Non-ASCII characters that Oh My Posh contains cause incorrect behavior with
# ble.sh
_set_kali_prompt() {
	local exit_code=$? # Exit code of the previous command
	local RESET='\[\e[0m\]'
	local RED='\[\e[0;31m\]'
	local GREEN='\[\e[0;32m\]'
	local BLUE='\[\e[0;34m\]'
	local WHITE='\[\e[0;37m\]'
	local YELLOW='\[\e[0;33m\]'
	local CYAN='\[\e[0;36m\]'

	local status_indicator=""
	if [[ $exit_code -eq 0 ]]; then
		status_indicator="✅"
	else
		status_indicator="❌"
	fi

	# First line: user, host, and path
	local prompt_line_1=""
	local prompt_line_2=""

	if [[ $EUID -eq 0 ]]; then # Check if user is root
		# Root prompt: +--(root☠hostname)
		prompt_line_1="${BLUE}+--(${RED}root☠\h${BLUE})"
		prompt_line_1+="-[${WHITE}📂 \w${BLUE}]"
		prompt_line_2="${BLUE}\\-${RED}# ${RESET}"
	else
		# Normal user prompt: +--(user㉿hostname)
		prompt_line_1="${GREEN}+--(${BLUE}\u㉿\h${GREEN})"
		prompt_line_1+="-[${WHITE}📂 \w${GREEN}]"
		prompt_line_2="${GREEN}\\-${BLUE}$ ${RESET}"
	fi

	# Add git branch if in a git repository
	local git_branch
	git_branch="$(parse_git_branch)"
	if [[ -n "$git_branch" ]]; then
		prompt_line_1+="-[${WHITE}🌱 $git_branch"
		if [[ $EUID -eq 0 ]]; then
			prompt_line_1+="${BLUE}]"
		else
			prompt_line_1+="${GREEN}]"
		fi
	fi

	if [[ -n "$VIRTUAL_ENV_PROMPT" ]]; then
		prompt_line_1+="-[${WHITE}🐍 $VIRTUAL_ENV_PROMPT"
		if [[ $EUID -eq 0 ]]; then
			prompt_line_1+="${BLUE}]"
		else
			prompt_line_1+="${GREEN}]"
		fi
	fi

	prompt_line_1+="-[${status_indicator}"
	if [[ $EUID -eq 0 ]]; then
		prompt_line_1+="${BLUE}]"
	else
		prompt_line_1+="${GREEN}]"
	fi

	# Set the final prompt
	PS1="${prompt_line_1}${RESET}\n${prompt_line_2}"
}

# This tells Bash to run our function every time before showing the prompt
PROMPT_COMMAND="_set_kali_prompt"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
