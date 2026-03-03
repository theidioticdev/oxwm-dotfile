# Exports
export EDITOR=nvim
export VISUAL='nvim'
export PYTHONDONTWRITEBYTECODE=1
export TERM=xterm-256color

# Better tab completion
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Colors
RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
YELLOW='\[\e[33m\]'
BLUE='\[\e[34m\]'
CYAN='\[\e[36m\]'
RESET='\[\e[0m\]'

# Prompt (green user, yellow directory)
PS1="${BLUE} \u${RESET} in ${YELLOW}\w${RESET} ~> $ "

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
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Grep with color
alias grep='rg --color=auto'

# Quick edit & reload bashrc
alias bashrc='nvim ~/.bashrc'
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
alias edit_pwos='nvim ~/penguwarpos/kernel.py'
alias dev='cd ~/pw-testing && nvim .'

# Configs
alias oxconf='nvim ~/.config/oxwm/config.lua'
alias wtfconfig='nvim ~/.config/wtf/config.yml'

# QoL (for me at least, as someone with 2 key layouts)
alias changekey="setxkbmap -layout us,eg -option 'grp:alt_shift_toggle'"

# Autostart
if [[ $- == *i* ]]; then
  figlet -c -f slant "~ BASH ~" | lolcat
  fastfetch
  changekey
fi
