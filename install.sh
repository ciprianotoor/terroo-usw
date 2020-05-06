#!/usr/bin/env bash
# script: install.sh
# description: Customize your Ubuntu with Wayland + Sway + Ulauncher + Waybar
# author: Marcos Oliveira <terminalroot.com.br>
# license: GPLv3
# dependences: git

_start(){
  read -n1 -p "Do you like start installation? [Y/n]: "
  [[ "$REPLY" == "y" ||  "$REPLY" == "Y" ]] && {
    printf "\n%s\n" "\o/"
  } || {
    echo
    exit 0
  }
}

_install_pkgs(){
  sudo apt install sway waybar vim mpd mpc ncmpcpp -y
  sudo add-apt-repository -y ppa:agornostal/ulauncher
  sudo apt update
  sudo apt install ulauncher -y
  sudo add-apt-repository --remove -y ppa:agornostal/ulauncher
  sudo apt update
}

_configs_pkgs(){
  mv sway/ ${HOME}/.config/
  sed -i "s/__USER__/$USER/" ${HOME}/.config/sway/config
  mv ulauncher/ ${HOME}/.config/
  mv wallpaper.jpg ${HOME}/.wallpaper.jpg
  mv waybar/ ${HOME}/.config/
  chmod +x ${HOME}/.config/waybar/waybar.sh
  mv fonts/ ${HOME}/.local/share/
  fc-cache -fv
  source ${HOME}/.bashrc
}


_msg_final(){
    clear
    printf "%s\n" "
    ███████╗██╗   ██╗ ██████╗ ██████╗███████╗███████╗███████╗██╗
    ██╔════╝██║   ██║██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝██║
    ███████╗██║   ██║██║     ██║     █████╗  ███████╗███████╗██║
    ╚════██║██║   ██║██║     ██║     ██╔══╝  ╚════██║╚════██║╚═╝
    ███████║╚██████╔╝╚██████╗╚██████╗███████╗███████║███████║██╗
    ╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝╚══════╝╚══════╝╚══════╝╚═╝
                END THE SESSION AND ENJOY!
    "
}

_start
_install_pkgs
_configs_pkgs
_msg_final
exit 0
