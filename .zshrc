# Last update 2026-01-24
# Switch to sheldon, starship, atuin, fnm and fzf-tab
# clean up

# Extend path with yarn, node, ruby and composer and personal bin
export PATH="$HOME/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/bin:$HOME/.config/composer/vendor/bin:$HOME/.bin:$HOME/.gem/ruby/2.4.0/bin:$HOME/.local/bin:/var/lib/snapd/snap/bin:$HOME/.emacs.d/bin:$HOME/.lmstudio/bin:$HOME/.bun/bin:$PATH"

# Editor annd settings
export EDITOR=nvim

# Compiling and Gentoo settings
export NUMCPUS=$(nproc)
export NUMCPUSPLUSONE=$(( NUMCPUS + 1 ))
export MAKEOPTS="-j$NUMCPUSPLUSONE -l$NUMCPUS"
export EMERGE_DEFAULT_OPTS="--jobs=$NUMCPUSPLUSONE --load-average=$NUMCPUS"

# Start SSH Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# GPG
export GPG_TTY=$(tty)

# Aliases
alias ls='eza --icons --git'
alias cat='bat'
alias grep='grep --color=auto'
alias ssh='TERM=xterm-256color \ssh'
alias cdwww='cd ~/srv'
alias em="emacsclient -nw"
alias vim="nvim"
alias emacs="emacsclient -c -a 'emacs'"
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# bun completions
[ -s "/home/bytee/.bun/_bun" ] && source "/home/bytee/.bun/_bun"


# Init Plugin manager
eval "$(sheldon source)"

# Tools
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh --cmd cd)"

autoload -Uz compinit && compinit

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'

setopt HIST_IGNORE_ALL_DUPS
setopt AUTO_CD
setopt AUTO_PUSHD

### End of Zinit's installer chunk

# Added by LM Studio CLI (lms)
# End of LM Studio CLI section

