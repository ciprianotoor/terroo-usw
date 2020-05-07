#!/usr/bin/env bash
# vim: noai:ts=4:sw=4:expandtab
################################################################################
# script: install.sh
# description: Customize your Ubuntu with Wayland + Sway + Ulauncher + Waybar
# author: Marcos Oliveira <terminalroot.com.br>
# license: GPLv3
# dependences: git
################################################################################

export _pkgs=(sway waybar vim mpd mpc ncmpcpp ulauncher)
export _conf="${HOME}/.config/"
export _lsf="${HOME}/.local/share"
export _wall="wallpaper.jpg"
export _sa=(sudo apt)
export _oth=(fonts fc-cache bashrc)

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
  ${_sa}-apt-repository -y ppa:agornostal/${_pkgs[6]}
  ${_sa} update
  ${_sa} install $(printf '%s ' "${_pkgs[@]}") -y
  ${_sa}-apt-repository --remove -y ppa:agornostal/${_pkgs[6]}
  ${_sa} update
}

_configs_pkgs(){
  mv ${_pkgs[0]} "${_conf}/"
  sed -i "s/__USER__/$USER/" "${_conf}/${_pkgs[0]}/config"
  mv "${_pkgs[6]}" "${_conf}/"
  mv ${_wall} "${HOME}/.${_wall}"
  mv ${_pkgs[1]} "${_conf}/"
  chmod +x "${_conf}/${_pkgs[1]}/${_pkgs[1]}.sh"
  mv ${_oth[0]} "${_lsf}/"
  ${_oth[1]} -fv
  source "${HOME}/.${_oth[2]}"
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
