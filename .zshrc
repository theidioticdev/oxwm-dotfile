# ── git integration ───────────────────────────────────────────────────────────
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST

# ── static named dirs ─────────────────────────────────────────────────────────
hash -d pwos=~/pw-testing/


# ── fzf integration ──────────────────────────────────────────────────────────
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_OPTS="--color=16,info:4,pointer:4,marker:4,spinner:4,header:4 --height 40% --layout=reverse --border"

# ── Prompt ────────────────────────────────────────────────────────────────────
zstyle ':vcs_info:git:*' formats ' on %F{cyan}%b%f'
zstyle ':vcs_info:*' enable git

PROMPT='%B%F{white}%n%b %F{244}in %B%F{white}%~%b${vcs_info_msg_0_}%f ~> '
# ── Plugins ───────────────────────────────────────────────────────────────────
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# ── History ───────────────────────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ── Navigation ────────────────────────────────────────────────────────────────
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

alias ..='cd ..'
alias ...='cd ../..'
alias back='popd'

# ── ls ────────────────────────────────────────────────────────────────────────
alias ls='eza --icons --color=auto'
alias ll='eza -lah'
alias la='eza -A'
cd() { 
  builtin cd "$@" && [ -t 1 ] && eza --icons --color=auto; 
}
# ── Safety nets ───────────────────────────────────────────────────────────────
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ── Better tools ─────────────────────────────────────────────────────────────
alias grep='rg --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# ── QoL ───────────────────────────────────────────────────────────────────────
alias c='clear'
alias ports='ss -tulanp'
alias please='sudo -i'
alias apt='man pacman'
alias apt-get='man pacman'
alias changekey="setxkbmap -layout us,eg -option 'grp:alt_shift_toggle'"
alias whereami='echo "Display: $DISPLAY | Wayland: $WAYLAND_DISPLAY | Session: $XDG_SESSION_TYPE"'
alias -g g='| grep'
alias -g l='| less'
alias -g h='| head'
alias -g t='| tail'
alias -g ne='2> /dev/null'
alias srb2='gamemoderun flatpak run org.srb2.SRB2'
alias befast='xset r rate 200 35'
# ── Config shortcuts ──────────────────────────────────────────────────────────
alias zshrc='$EDITOR ~/.zshrc'
alias reload='source ~/.zshrc'
alias oxconf='nvim ~/.config/oxwm/config.lua'
alias wtfconfig='$EDITOR ~/.config/wtf/config.yml'
alias piconf='$EDITOR ~/.config/picom/picom.conf'
alias dots='cd ~/dotfiles/oxwm-dotfile/ && $EDITOR .'

# ── Editor ────────────────────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim
export PYTHONDONTWRITEBYTECODE=1
export TERM=xterm-256color

# ── Projects ─────────────────────────────────────────────────────────────────
alias pwos-dev='python3  ~pwos/kernel.py'
alias dev='cd ~/pw-testing && $EDITOR .'
alias suckless='cd ~/dotfiles/suckless/'
alias zshfetch='figlet -f slant "~ ZSH ~" | lolcat && fastfetch'
# ── Functions ─────────────────────────────────────────────────────────────────
mkcd() { mkdir -p "$1" && cd "$1"; }

extract() {
  case "$1" in
    *.tar.gz|*.tgz)   tar xzf "$1"  ;;
    *.tar.bz2)        tar xjf "$1"  ;;
    *.zip)            unzip "$1"    ;;
    *.7z)             7z x "$1"     ;;
    *.rar)            unrar x "$1"  ;;
    *.tar.xz)         tar xJf "$1"  ;;
    *)                echo "bro idk what this is" ;;
  esac
}
compress() {
  tar -cvzf "${1%/}.tar.gz" "$1"
}

# ── Package manager wrapper ───────────────────────────────────────────────────
_pkgmgr_update() {
  echo "-- 📰 Checking Arch News... --"
  curl -s https://archlinux.org/feeds/news/ | grep -oP '(?<=<title>).*?(?=</title>)' | sed '1,2d' | head -n 3

  echo "-- 🔄 Refreshing repos and upgrading system... --"
  yay -Syu || { echo " Update failed!"; return 1; }

  echo "--  Removing orphaned dependencies... --"
  local orphans=$(pacman -Qdtq)
  if [[ -n $orphans ]]; then
    sudo pacman -Rns $orphans
  else
    echo "No orphans to clean."
  fi

  echo "--  Clearing cache... --"
  yay -Sc --noconfirm
  echo "--  System update complete! enjoy your system :3 --"
}

pkgmgr() {
  case "$1" in
    update)   _pkgmgr_update ;;
    install)  shift; yay -S "$@" && echo "-- Done! enjoy your new package(s) :3 --" ;;
    remove)   shift; yay -Rs "$@" && echo "-- Done! Package(s) removed :3 --" ;;
    search)   shift; yay -Ss "$@" ;;
    info)     shift; yay -Qi "$@" ;;
    cleanup)  sudo pacman -Rsn $(pacman -Qtdq) ;;
    *)        echo "Usage: pkgmgr {update|install|remove|search|info|cleanup} [package]" ;;
  esac
}


command_not_found_handler() {
    echo "zsh: command not found: $1"
    echo -n "Check pkgmgr for '$1'? (y/n) "
    read -r answer
    if [[ "$answer" == "y" ]]; then
        pkgmgr search "$1"
    fi
}
# ── Autostart ─────────────────────────────────────────────────────────────────
if [[ $- == *i* ]]; then
  figlet -f AnsiShadow "ZSH >_" | lolcat
  fastfetch

  if [[ -n "$DISPLAY" && -z "$WAYLAND_DISPLAY" ]]; then
    changekey 2>/dev/null
  fi
fi
