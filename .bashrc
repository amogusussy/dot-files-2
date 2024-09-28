export PATH=$PATH:~/.local/bin

if [[ $- != *i* ]]; then
  return # If not running interactively, don't do anything
fi

# Run startx when in tty
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  # export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
  # if ! test -d "${XDG_RUNTIME_DIR}"; then
  #   mkdir "${XDG_RUNTIME_DIR}"
  #   chmod 0700 "${XDG_RUNTIME_DIR}"
  # fi
  startx &
fi

# General aliases
PS1="$(date +%I:%M) \W $ "
alias ls="lsd"
alias q='exit'
alias ':q'='exit'
alias ':q!'='exit'
alias qq='exit'
alias python='python3'
alias grep='grep --color=auto'
alias fdd=fd
alias wc-l='wc -l'
alias yt-dlp="yt-dlp --config-locations $HOME/.config/yt-dlp/yt-dlp.conf"

# Vim aliases 
alias vim='nvim'
alias vi='nvim'
alias nvi='nvim'
alias vm='nvim'
alias vim='nvim'

alias avim="NVIM_APPNAME=astrovim nvim"


# Kill Commands
alias ks='pkill -f "^[CZ]:|steam|steamwebhelper|valve|bwrap steam"'
alias kq='pkill qbittorrent'
alias ke='pkill electron'
alias kf='pkill firefox'
alias kl='pkill librewolf'
alias kx='pkill Xorg'
alias kd='pkill discord && pkill socat'

# Doas 
alias dias='doas'
alias dooas='doas'
alias doaas='doas'
alias doass='doas'

# Other
alias record='ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -c:v libx264 -preset veryfast $(date "+%s").mkv' 
alias l='ls'
alias s='ls'
alias lls='ls'
alias lsl='ls'
alias cls='ls'
alias sl='ls'
alias sls='ls'
alias la='ls'
alias ll='ls'
alias ccd='cd'
alias d='cd'

# Clear
alias lear="clear"
alias cclear="clear"
alias lclear="clear"

# Auto Complete
complete -cf doas
complete -cf pkill
complete -cf which
complete -cf xbps-remove
complete -cf man
complete -cf time
complete -cf xargs
complete -cf cpulimit
complete -cf torsocks
complete -cf type
complete -d cd
source /usr/share/bash-completion/completions/git


shred_dir() {
  for i in "$@"
  do
    fd -t f -0a --base-directory "$i" | xargs -0 /bin/shred -zn 1
  done
}

reverse-output() {
  if [[ "$(pactl get-default-sink)" = "reverse-stereo" ]]; then
    printf "Audio already reversed\n"
    return
  fi
  pactl load-module module-remap-sink \
    sink_name=reverse-stereo \
    master=0 \
    channels=2 \
    master_channel_map=front-right,front-left \
    channel_map=front-left,front-right
  pactl set-default-sink reverse-stereo
}

make_virt_env() {
  virtualenv -p python3 env
  source ./env/bin/activate
  pip3 install --upgrade pip
  if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
  fi
}

stream() {
  streamlink -p mpv $1 best
}

up() {
  cd $(printf "%.s../" $(seq "$1"))
}

clear() {
  printf '\E[H\E[J'
}

update() {
  distro=$(lsb_release -cs)
  if [[ $distro == "void" ]]; then
    doas xbps-install -Syu
  elif [[ $distro == "arch" ]]; then
    doas pacman -Syu
  fi

  flatpak update -y
}

rmnvswap() {
  file="$(printf "$(pwd)/$1\n" | sed -e "s/\//%/g").swp"
  rm -f "$HOME/.local/state/nvim/swap/$file"
}

paste-file() {
  curl -F "file=@$1" https://0x0.st
}

backup() {
  excludes=$(printf " --exclude=\"%s\"" $(ls ~/.var/app/ -1 | /bin/grep -Pv "librewolf"))

  echo $excludes | xargs rsync -av . /mnt/SteamDrive/Backups/2024-09-18-Backup/ \
    --exclude=.games/ \
    --exclude=Torrents \
    --exclude=.cache/ \
    --exclude=~/.var/app/com.valvesoftware.Steam/.local/ \
    --exclude=$HOME/.var/app/com.github.Eloston.UngoogledChromium/ \
    --exclude=Youtube/ \
    --exclude="*.webm" \
    --exclude="pyc" \
    --exclude="__pycache__" \
    --exclude=".cargo" \
    --exclude="pyc" \
    --exclude="$HOME/.local/share/flatpak" \
    --exclude="tor-browser"
}

trash_rm () {
  local args=()
  for arg in "$@"; do
    if [[ $arg == -* ]]; then
      # this argument starts with a dash, so we assume it's an option and skip it
      continue
    fi
    args+=("$arg")
  done

  if [[ ${#args[@]} -eq 0 ]]; then
    echo "Error: No files or directories specified"
    return 1
  fi

  for arg in "${args[@]}"; do
    gio trash "$arg"
  done
}

mpv() {
  local replacements=("piped.kavin.rocks" "piped.projectsegfau.lt" "piped.in.projectsegfau.lt" "piped.video" "yewtu.be" )
  local args=("$@")
  local replaced_args=()

  for arg in "${args[@]}"; do
    local replaced_arg="$arg"
    for replacement in "${replacements[@]}"; do
      if [[ "$arg" == *"$replacement"* ]]; then
        replaced_arg="${replaced_arg//$replacement/youtube.com}"
      fi
    done
    replaced_args+=("$replaced_arg")
  done
  echo "${replaced_args[@]}"
  /bin/mpv "${replaced_args[@]}"
}

scrot() {
  /bin/scrot -F ~/Pictures/screenshots/$(date "+%s").png $@
}

printf "\e]0;haxxor terminal"
export EDITOR='nvim'

# History
export HISTSIZE=1000000000
export HISTFILESIZE=1000000000
export HISTTIMEFORMAT='%d/%m/%y %T '
export HISTCONTROL=ignoredups
export HISTIGNORE=' *:q:qq:clear:clea:shred:ckear:#:ks:kl:kq:m:history'

export XDG_RUNTIME_DIR=/run/user/$(id -u)
