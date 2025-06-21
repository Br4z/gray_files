#!/bin/bash
#  ______   ______   ______   __  __       __    __   ______   __   __   ______   ______   ______   ______
# /\  ___\ /\  == \ /\  __ \ /\ \_\ \     /\ "-./  \ /\  __ \ /\ "-.\ \ /\  __ \ /\  ___\ /\  ___\ /\  == \
# \ \ \__ \\ \  __< \ \  __ \\ \____ \    \ \ \-./\ \\ \  __ \\ \ \-.  \\ \  __ \\ \ \__ \\ \  __\ \ \  __<
#  \ \_____\\ \_\ \_\\ \_\ \_\\/\_____\    \ \_\ \ \_\\ \_\ \_\\ \_\\"\_\\ \_\ \_\\ \_____\\ \_____\\ \_\ \_\
#   \/_____/ \/_/ /_/ \/_/\/_/ \/_____/     \/_/  \/_/ \/_/\/_/ \/_/ \/_/ \/_/\/_/ \/_____/ \/_____/ \/_/ /_/


source "$HOME/.local/bin/colors_and_helpers"
set -euo pipefail

# Description: handle the Ctrl+C signal and exit the program.
# Parameters: none.
function cleanup() {
	# Restore cursor only for interactive runs
	if [[ -t 1 ]]; then
		tput cnorm || true
	fi
}

trap cleanup EXIT

# --------------------------- DEFAULT AND CONSTANTS -------------------------- #

dotfiles_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

declare -r files=(
	"bspwm"
	"firefox"
	"bin"
	"sxhkd"
	"kitty"
	"bashrc"
	"bash_utilities"
	"bash_profile"
	"nvim"
	"polybar"
	"qt5ct"
	"rofi"
	"xcfe4"
)

declare -r target_paths=(
	"$dotfiles_path/bspwm"
	"$dotfiles_path/firefox"
	"$dotfiles_path/scripts"
	"$dotfiles_path/sxhkd"
	"$dotfiles_path/kitty"
	"$dotfiles_path/bash/.bashrc"
	"$dotfiles_path/bash/.bash_utilities"
	"$dotfiles_path/bash/.bash_profile"
	"$dotfiles_path/nvim"
	"$dotfiles_path/polybar"
	"$dotfiles_path/qt5ct/everything_i_see_is_gray.conf"
	"$dotfiles_path/rofi"
	"$dotfiles_path/xfce4"

)

declare -r link_paths=(
	".config/bspwm"
	".mozilla/firefox"
	".local/bin"
	".config/sxhkd"
	".config/"
	""
	""
	""
	".config/nvim"
	".config/polybar"
	".config/qt5ct/colors"
	".config/rofi"
	".config/xfce4/xfconf/xfce-perchannel-xml"
)

# Ensure metadata integrity
if [[ ${#files[@]} -ne ${#target_paths[@]} || ${#files[@]} -ne ${#link_paths[@]} ]]; then
	error "array length mismatch\n"
	exit 1
fi

# ------------------------------- USAGE BANNER ------------------------------- #

# Description: displays the help panel with usage instructions for the script.
# Parameters: none.
function usage() {
	info "Usage:\n"
	local idx
	for idx in "${!files[@]}"; do
		echo -e "${green_color}$i${end_color}) File: ${files[i]} Target: ${target_paths[i]}"
	done

	echo -e "$\t${magenta_color}-i${end_color} index [index ...]"
	echo -e "$\t${magenta_color}-h${end_color} show this help panel\n"
}

# Description: validates if the given index is a valid index.
# Parameters: none.
function validate_index() {
	local idx=$1
	if [[ ! $option =~ ^[0-9]+$ ]]; then
		error "${idx} is a invalid index" >&2
		exit 1
	fi

	if (( idx >= ${#files[@]} )); then
		error "${idx} index is out of range" >&2
		exit 1
	fi
}

# Description: applies dotfiles by creating symbolic links from target paths to link paths.
# Parameters:
# 	- $@: The indices of the dotfiles to apply.
function apply_dotfiles() {
	local idx source dest
	for idx in "$@"; do
		validate_index "$idx$"
		source="${target_paths[$idx]}"
		dest="$HOME/${link_paths[$idx]}"
		# Create destination parent directory if it does not exist
		mkdir -p "$(dirname -- "$dest")"
		echo -e "${blue_color}$source${end_color} -> ${blue_color}$dest${end_color}"
		ln -fs "$source" "$dest"
	done
}

# ----------------------------- PARSE CLI OPTIONS ---------------------------- #

if [[ $# -eq 0 ]]; then
	usage
	exit 0
fi

while getopts ":hi" opt; do
	case $opt in
		h)
			usage
			exit 0
			;;
		i) ;;
		\?)
			error "$OPTARG is a unknown option"
			usage
			exit 1
			;;
	esac
done
shift $((OPTIND - 1))

# If -i was given, remaining arguments are indices
apply_dotfiles "$@"
