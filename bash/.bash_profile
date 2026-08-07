#!/bin/bash
#  ______  ______   ______   ______  __   __       ______
# /\  == \/\  == \ /\  __ \ /\  ___\/\ \ /\ \     /\  ___\
# \ \  _-/\ \  __< \ \ \/\ \\ \  __\\ \ \\ \ \____\ \  __\
#  \ \_\   \ \_\ \_\\ \_____\\ \_\   \ \_\\ \_____\\ \_____\
#   \/_/    \/_/ /_/ \/_____/ \/_/    \/_/ \/_____/ \/_____/

if [[ -f "$HOME/.bash_utilities" ]]; then
  source "$HOME/.bash_utilities"
fi

source_file "$HOME/.bashrc"
source_file "/usr/share/nvm/init-nvm.sh"

add_to_path "$HOME/.spicetify/"
add_to_path "$HOME/.local/bin/"
add_to_path "$HOME/.local/scripts/"
add_to_path "$HOME/go/bin/"
add_to_path "$HOME/.dotnet/tools/"
