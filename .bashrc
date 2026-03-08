# Exports
export EDITOR=nvim
export VISUAL='nvim'
export PYTHONDONTWRITEBYTECODE=1
export TERM=xterm-256color

# Better tab completion
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Prompt
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'; PS1='\[\e[97m\]\u \[\e[90m\]in \[\e[97m\]\W\[\e[33m\]${PS1_CMD1}\[\e[0m\] ~> '
# History
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'

# ls aliases
alias ls='eza --color=auto'
alias ll='eza -lah'
alias la='eza -A'

# Safety nets
unalias rm 2>/dev/null
rm() {
    local has_r=false has_f=false
    for arg in "$@"; do
        [[ "$arg" == -* ]] || continue
        [[ "$arg" == *r* || "$arg" == *R* ]] && has_r=true
        [[ "$arg" == *f* || "$arg" == *F* ]] && has_f=true
    done
    if $has_r && $has_f; then
        read -p "⚠ rm -rf detected. are you sure? [y/N]: " confirm
        [[ "$confirm" == "y" ]] || return 1
    else
        command rm -i "$@"
        return
    fi
    command rm "$@"
}

alias cp='cp -i'
alias mv='mv -i'


# Grep with color
alias grep='rg --color=auto'

# Quick edit & reload bashrc
alias bashrc='micro ~/.bashrc'
alias reload='source ~/.bashrc'

# Disk & memory
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Misc
alias c='clear'
alias h='history'
alias ports='ss -tulanp'

# Projects
alias pwos='python3 ~/penguwarpos/kernel.py'
alias pwos-dev='python3 ~/pw-testing/kernel.py'
alias dev='cd ~/pw-testing && nvim .'
alias dots='cd ~/dotfiles && nvim .'
alias suckless='cd ~/dotfiles/suckless/'

# Configs
alias oxconf='nvim ~/.config/oxwm/config.lua'
alias wtfconfig='micro ~/.config/wtf/config.yml'
alias niriconf='micro ~/.config/niri/config.kdl'
alias cat-theme='kitten themes'

# QoL (for me at least, as someone with 2 key layouts)
 alias changekey="setxkbmap -layout us,eg -option 'grp:alt_shift_toggle'"
alias srb2='gamemoderun flatpak run org.srb2.SRB2  '
# Autostart
source ~/.config/git/git-prompt.sh
if [[ $- == *i* ]]; then
  figlet "~ BASH ~" | lolcat
  fastfetch
  changekey
fi
