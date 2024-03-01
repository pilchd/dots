#!/bin/sh

TARGETS=(
    '.bash_aliases'
    '.bash_git-prompt.sh'
    '.bash_profile'
    '.bashrc'
    '.gitconfig'
    '.gitignore'
    '.gtkrc-2.0'
    '.inputrc'
    '.npmrc'
    '.arduino15/arduino-cli.yaml'
    '.config/bc/config'
    '.config/Code/User/keybindings.json'
    '.config/Code/User/settings.json'
    '.config/Code/User/snippets/global.code-snippets'
    '.config/exiftool/format.fmt'
    '.config/feh/buttons'
    '.config/feh/keys'
    '.config/feh/themes'
    '.config/fontconfig/fonts.conf'
    '.config/gtk-3.0/settings.ini'
    '.config/gtk-4.0/settings.ini'
    '.config/kitty/kitty.conf'
    '.config/kitty/kitty.conf.d/keys.conf'
    '.config/kitty/kitty.conf.d/themes/One-Dark-Pro.conf'
    '.config/mako/config'
    '.config/nano/nanorc'
    '.config/sway/config'
    '.config/sway/config.d/inputs'
    '.config/sway/config.d/windows'
    '.config/sway/config.d/keys/de'
    '.config/sway/config.d/keys/sway'
    '.config/sway/config.d/outputs/main'
    '.config/sway/config.d/outputs/sub'
    '.config/sway/config.d/themes/One-Dark-Pro'
    '.config/sway/sh/clipboard.sh'
    '.config/sway/sh/run.sh'
    '.config/sway/sh/screenshot.sh'
    '.config/swaylock/config'
    '.config/tio/config'
    '.config/tofi/config'
    '.config/user-dirs.dirs'
    '.config/waybar/config'
    '.config/waybar/style.css'
    '.config/waybar/sh/sway-workspace-focused.sh'
    '.config/waybar/sh/wx.sh'
    '.config/xdg-desktop-portal-termfilechooser/config'
    '.config/xdg-desktop-portal-termfilechooser/tofi.sh'
    '.local/share/appimagekit/no_desktopintegration'
    '.ssh/config'
)

case "$1" in

    "generate")
        for path in "${TARGETS[@]}"; do
            mkdir -p "$(dirname "${path}")"
            ln -f "${HOME}/${path}" "${path}"
        done
    ;;

    "install")
        for path in "${TARGETS[@]}"; do
            mkdir -p "${HOME}/$(dirname "${path}")"
            ln -f "${path}" "${HOME}/${path}"
        done
    ;;

    *)
        echo "$0 generate | install"
    ;;

esac
