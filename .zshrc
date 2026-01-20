export PATH=$PATH:~/.local/bin

# Exit if not running interactively
[[ $- != *i* ]] && return

# Run startx when in tty
if [[ -z $DISPLAY && $(tty) == /dev/tty1 ]]; then
  # export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
  # if [[ ! -d "${XDG_RUNTIME_DIR}" ]]; then
  #   mkdir "${XDG_RUNTIME_DIR}"
  #   chmod 0700 "${XDG_RUNTIME_DIR}"
  # fi
  startx &
fi

autoload -Uz promptinit && promptinit
precmd() { vcs_info }
setopt prompt_subst

autoload -Uz vcs_info
precmd() { vcs_info }

autoload -U select-word-style
select-word-style bash

zstyle ':vcs_info:git:*' formats ' %b%u'
zstyle ':vcs_info:*' enable git

setopt prompt_subst
PS1='%F{75}%D{%H:%M}%f %F{113}%~%f %F{140}${vcs_info_msg_0_}%f %# '

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias ls="lsd"
alias q='exit'
alias ':q'='exit'
alias ':q!'='exit'
alias qq='exit'
alias python='python3'
alias grep='grep -I --color=auto --exclude-dir={.git,env,__pycache__}'
alias fdd=fd
alias wc-l='wc -l'
alias yt-dlp="yt-dlp --config-locations $HOME/.config/yt-dlp/yt-dlp.conf"

# Vim aliases
alias vim='nvim'
alias vi='nvim'
alias nvi='nvim'
alias vm='nvim'
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


autoload -Uz compinit
compinit

# Autocompletion
compctl -f doas
compctl -f pkill
compctl -f which
compctl -f xbps-remove
compctl -f man
compctl -f time
compctl -f xargs
compctl -f cpulimit
compctl -f torsocks
compctl -f type
compctl -/ cd
# source /usr/share/bash-completion/completions/git

# Functions
shred_dir() {
  for i in "$@"; do
    fd -t f -0a --base-directory "$i" | xargs -0 /bin/shred -zn 1
  done
}

reverse-output() {
  if [[ "$(pactl get-default-sink)" == "reverse-stereo" ]]; then
    printf "Audio already reversed\n"
    return
  fi

  sink_number="$(pactl list short sinks | grep "analog-stereo" | awk '{print $1}')"
  output="$(pactl load-module module-remap-sink sink_name='reverse-stereo' master=$sink_number channels=2 master_channel_map=front-right,front-left channel_map=front-left,front-right)"

  if [[ $? == 0 ]]; then
    pactl set-default-sink "reverse-stereo"
  fi
}

make_virt_env_11() {
  virtualenv -p "python3.11" env
  source ./env/bin/activate
  pip3.11 install --upgrade pip
  [[ -f "requirements.txt" ]] && pip install -r requirements.txt
}

make_virt_env() {
  virtualenv -p python3 env
  source ./env/bin/activate
  pip3 install --upgrade pip
  [[ -f "requirements.txt" ]] && pip install -r requirements.txt
}

stream() {
  streamlink -p mpv "$1" best
}

up() {
  local count="$1"
  local path=""
  for i in $(seq "$count"); do
    path+="../"
  done
  cd "$path"
}

# clear() {
#   printf '\E[H\E[J'
# }
#
update() {
  local distro=$(lsb_release -cs)
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
  local excludes=$(printf " --exclude=\"%s\"" $(ls ~/.var/app/ -1 | grep -Pv "librewolf"))
  echo $excludes | xargs rsync -av . /mnt/SteamDrive/Backups/2025-07-21-Backup/ \
    --exclude=.games/ \
    --exclude=Torrents \
    --exclude=.cache/ \
    --exclude="$HOME/.var/app/com.valvesoftware.Steam/.local/" \
    --exclude="$HOME/.var/app/com.github.Eloston.UngoogledChromium/" \
    --exclude=Youtube/ \
    --exclude="*.webm" \
    --exclude="pyc" \
    --exclude="__pycache__" \
    --exclude=".cargo" \
    --exclude=".local/share/flatpak/" \
    --exclude="tor-browser" \
    --exclude="$HOME/Videos/" \
    --exclude="Unity" \
    --exclude="whonix" \
    --exclude="Jellyfin"
}

trash_rm() {
  local args=()
  for arg in "$@"; do
    [[ $arg == -* ]] && continue
    args+=("$arg")
  done

  [[ ${#args[@]} -eq 0 ]] && {
    echo "Error: No files or directories specified"
    return 1
  }

  for arg in "${args[@]}"; do
    gio trash "$arg"
  done
}

mpv() {
  local replacements=("piped.kavin.rocks" "piped.projectsegfau.lt" "piped.in.projectsegfau.lt" "piped.video" "yewtu.be")
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

movie() {
  mpv --wid=$(xdotool getactivewindow) "$1"
}

scrot() {
  /bin/scrot -F ~/Pictures/screenshots/$(date "+%s").png "$@"
}

paste-file() {
  curl -F "file=@$1" https://0x0.st
}

print -n "\e]0;haxxor terminal\a"

export EDITOR='nvim'

# History
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT='%d/%m/%y %T '
setopt hist_ignore_dups
setopt hist_ignore_space
export HISTIGNORE=' *:q:qq:clear:clea:shred:ckear:#:ks:kl:kq:m:history'

export XDG_RUNTIME_DIR=/run/user/$(id -u)

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$HOME/.dotnet:$PATH
export PATH=$PATH:"$HOME/.dotnet/tools"
export PATH=$PATH:/home/matthew/.spicetify


bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

[ -f "/home/matthew/.ghcup/env" ] && . "/home/matthew/.ghcup/env" # ghcup-env
