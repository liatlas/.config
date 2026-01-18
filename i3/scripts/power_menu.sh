#!/usr/bin/env bash
# Use a custom lock script
#LOCKSCRIPT="i3lock-extra -m pixelize"

# Colors: FG (foreground), BG (background), HL (highlighted)
FG_COLOR="${FG_COLOR:-#bbbbbb}"
BG_COLOR="${BG_COLOR:-#111111}"
HLFG_COLOR="${HLFG_COLOR:-#111111}"
HLBG_COLOR="${HLBG_COLOR:-#bbbbbb}"
BORDER_COLOR="${BORDER_COLOR:-#222222}"

# Options not related to colors
ROFI_TEXT="${ROFI_TEXT:-Menu:}"
ROFI_OPTIONS=(${ROFI_OPTIONS:--theme-str 'window {width: 11%; border: 2;} listview {scrollbar: false;}' -location 0})

# Whether to ask for user's confirmation
enable_confirmation=${ENABLE_CONFIRMATIONS:-true}

# Preferred launcher if both are available
preferred_launcher="${LAUNCHER:-rofi}"


# Check whether the user-defined launcher is valid

# Parse CLI arguments
while getopts "hcp:" option; do
  case "${option}" in
    h) echo "${usage}"
       exit 0
       ;;
    c) enable_confirmation=true
       ;;
    p) preferred_launcher="${OPTARG}"
       check_launcher "${preferred_launcher}"
       ;;
    *) exit 1
       ;;
  esac
done
check_launcher "${preferred_launcher}"

# Check whether a command exists
function command_exists() {
  command -v "$1" &> /dev/null 2>&1
}

# systemctl required
if ! command_exists systemctl ; then
  exit 1
fi

# menu defined as an associative array
typeset -A menu

# Menu with keys/commands
menu=(
  [Shutdown]="systemctl poweroff"
  [Reboot]="systemctl reboot"
  [Hibernate]="systemctl hibernate"
  [Suspend]="systemctl suspend"
  [Halt]="systemctl halt"
  [Lock]="${LOCKSCRIPT:-i3lock --color=${BG_COLOR#"#"}}"
  [Logout]="i3-msg exit"
  [Cancel]=""
)
menu_nrows=${#menu[@]}

# Menu entries that may trigger a confirmation message
menu_confirm="Shutdown Reboot Hibernate Suspend Halt Logout"

launcher_exe="rofi"
launcher_options=""
rofi_colors=""

function prepare_launcher() {
  if [[ "$1" == "rofi" ]]; then
    rofi_colors=(-bc "${BORDER_COLOR}" -bg "${BG_COLOR}" -fg "${FG_COLOR}" \
        -hlfg "${HLFG_COLOR}" -hlbg "${HLBG_COLOR}")
    launcher_exe="rofi"
    launcher_options=(-dmenu -i -lines "${menu_nrows}" -p "${ROFI_TEXT}" \
        "${rofi_colors[@]}" "${ROFI_OPTIONS[@]}")
  fi
}


prepare_launcher "rofi"


launcher=(${launcher_exe} "${launcher_options[@]}")
selection="$(printf '%s\n' "${!menu[@]}" | sort | "${launcher[@]}")"

function ask_confirmation() {
  if [ "${launcher_exe}" == "rofi" ]; then
    confirmed=$(echo -e "Yes\nNo" | rofi -dmenu -i -lines 2 -p "${selection}?" \
      "${rofi_colors[@]}" "${ROFI_OPTIONS[@]}")
    [ "${confirmed}" == "Yes" ] && confirmed=0
  fi

  if [ "${confirmed}" == 0 ]; then
    i3-msg -q "exec ${menu[${selection}]}"
  fi
}

if [[ $? -eq 0 && ! -z ${selection} ]]; then
  if [[ "${enable_confirmation}" = true && \
        ${menu_confirm} =~ (^|[[:space:]])"${selection}"($|[[:space:]]) ]]; then
    ask_confirmation
  else
    i3-msg -q "exec ${menu[${selection}]}"
  fi
fi
