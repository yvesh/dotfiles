# Last update 2021-05-30

# Extend path with yarn, node, ruby and composer and personal bin
export PATH="$HOME/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/bin:$HOME/.config/composer/vendor/bin:$HOME/.bin:$HOME/.gem/ruby/2.4.0/bin:$HOME/.local/bin:/var/lib/snapd/snap/bin:$HOME/.emacs.d/bin:$PATH"

# Editor and visual Settings
export EDITOR=vim

# Compiling
export NUMCPUS=$(nproc)
export NUMCPUSPLUSONE=$(( NUMCPUS + 1 ))
export MAKEOPTS="-j$NUMCPUSPLUSONE -l$NUMCPUS"

# Gentoo only
export EMERGE_DEFAULT_OPTS="--jobs=$NUMCPUSPLUSONE --load-average=$NUMCPUS"

# Start SSH Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

# Xdebug remote
export XDEBUG_CONFIG="remote_enable=1 remote_mode=req remote_port=9000 remote_host=127.0.0.1"

# Scaling
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export GDK_SCALE=1

# Wayland specific
# export _JAVA_AWT_WM_NONREPARENTING=1

# QEMU 
export QEMU_AUDIO_DRV=alsa
export QEMU_ALSA_DAC_BUFFER_SIZE=512
export QEMU_ALSA_DAC_PERIOD_SIZE=128

# GPG
export GPG_TTY=$(tty)

# Aliases
alias ls='ls --color'
alias ssh='TERM=xterm-256color \ssh'
alias cdwww='cd ~/srv'
alias em="emacsclient -nw"
alias vim="nvim"
alias emacs="emacsclient -c -a 'emacs'"
alias grep='grep --color=auto'
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

### Added by Zplugin's installer
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zplugin's installer chunk

zinit ice wait"0" blockf
zinit light zsh-users/zsh-completions

zinit ice wait"0" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait"0" atinit"zpcompinit; zpcdreplay"
# zinit light zdharma-continuum/fast-syntax-highlighting

zinit light zsh-users/zsh-history-substring-search
# zinit light trapd00r/zsh-syntax-highlighting-filetypes

# zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

# OMZ libraries
local _ZSHRC_OMZ_LIBS=(
  compfix.zsh
  completion.zsh
  directories.zsh
  functions.zsh
  grep.zsh
  history.zsh
  key-bindings.zsh
  misc.zsh
  spectrum.zsh
  termsupport.zsh
  theme-and-appearance.zsh
)

zinit ice from"gh" pick"lib/git.zsh" nocompletions blockf \
  atload'!local f; for f in ${_ZSHRC_OMZ_LIBS}; do source lib/$f; done' \
  compile"lib/(${(j.|.)_ZSHRC_OMZ_LIBS})"
zinit load robbyrussell/oh-my-zsh

# Theme
zinit light caiogondim/bullet-train-oh-my-zsh-theme

BULLETTRAIN_PROMPT_ORDER=(
  time
  context
  git
  dir
)

### End of Zinit's installer chunk

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# bun completions
[ -s "/home/bytee/.bun/_bun" ] && source "/home/bytee/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

