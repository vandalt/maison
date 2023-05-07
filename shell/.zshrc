# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
if ! [[ "$PATH" =~ "$HOME/.cargo/bin" ]]
then
  PATH="$HOME/.cargo/bin:$PATH"
fi
if ! [[ "$PATH" =~ "$HOME/go/bin" ]]
then
  PATH="$HOME/go/bin:$PATH"
fi

# Put extra completions in zfunc
fpath+=~/.zfunc

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# source ~/programs/powerlevel10k/powerlevel10k.zsh-theme
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function precmd () {
  echo -ne "\033]0;$(pwd | sed -e "s;^$HOME;~;")\a"
}

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

setopt autocd

zstyle ':compinstall:*' menu select
autoload -Uz compinit
compinit

source ~/.zsh/keybindings.zsh
source ~/.zsh/git.zsh
source ~/.zsh/python.zsh
source ~/.zsh/onedrive.zsh

# Must be after vi/emacs mode
# source /usr/share/fzf/shell/key-bindings.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Utils
alias l='ls'
alias sl='ls'
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -a'
alias lsd='ls -d'
alias lt='ls -lt'
alias ltr='ls -ltr'
alias treei='tree --gitignore'
alias rmr='rm -rI'
alias dh='du -sch *'
alias dha='du -d 1 -h .'
alias untar='tar -xvf'
alias guntar='tar -xzvf'
alias buntar='tar -xjvf'
alias open='xdg-open'
alias ...="cd ../.."
alias gof="open ."
alias scls="screen -ls"
alias slack="/usr/bin/slack --ozone-platform=wayland"

alias t='task'

# Mutt
alias mutt='neomutt'
alias muttr='neomutt -R'

# Mathematica wayland
# alias mathematica='QT_QPA_PLATFORM=xcb mathematica'

# Clone and update AUR in aur dir
alias auracle='auracle -C ~/aur'

# Editor
export EDITOR='nvim'
alias v='nvim'
alias vim='nvim'
# To enable reverse search with synctex by double-clicking PDF
alias vimtex='NVIM_LISTEN_ADDRESS=/tmp/texsocket nvim'
alias code='code --enable-features=UseOzonePlatform --ozone-platform=wayland'

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then 
  alias nvim="nvr -cc split --remote-wait +'set bufhidden=wipe'"
fi
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi

# -a is to have multiple FIFO parallel for preview, -A is to disable type-to-nav
alias nnn='nnn -aA'
export NNN_PLUG='z:autojump;f:fzopen;x:xdgdefault;p:preview-tui'
export NNN_FIFO=/tmp/nnn.fifo

# Notifications in sway
# NOTE: No "toggle" for mako modes yet (https://github.com/emersion/mako/pull/382)
alias dnd='makoctl mode -s dnd'
alias dndoff='makoctl mode -s default'

# Quick access to config files
alias cnvim='z ~/.config/nvim; nvim init.lua; z -'
alias cs='nvim ~/.config/sway/config'
alias cterm='nvim ~/.config/kitty/kitty.conf'
alias ctask='nvim ~/.config/task/taskrc'
alias zshrc='nvim ~/.zshrc'

# alias jwst-apt='~/programs/APT/APT'

setopt +o nomatch
alias tclean='rm *.aux *.fls *.fdb_latexmk *.log *.out *.vrb *.nav *.snm *.synctex.* *.toc *.bbl *.blg *.lof'

export THEANO_FLAGS=blas__ldflags="-L/usr/lib/ -lopenblas"
# export XLA_FLAGS="--xla_force_host_platform_device_count=4"
# export MKL_DYNAMIC=FALSE
# export MKL_CBWR=COMPATIBLE
# export OMP_NUM_THREADS=1
# export OPENBLAS_NUM_THREADS=1
# export MKL_NUM_THREADS=1
# export VECLIB_MAXIMUM_THREADS=1
# export NUMEXPR_NUM_THREADS=1
export XLA_FLAGS="--xla_force_host_platform_device_count=8 --xla_cpu_multi_thread_eigen=false intra_op_parallelism_threads=1"
export WEBBPSF_PATH=$HOME/Documents/data/package-data/webbpsf-data
export PYSYN_CDBS=$HOME/Documents/data/package-data/trds
export CRDS_PATH=$HOME/Documents/data/package-data/crds_cache
export CRDS_SERVER_URL=https://jwst-crds.stsci.edu
export MIRAGE_DATA=$HOME/Documents/data/package-data/mirage-data/mirage_data
# Dsiable jupyter "frozen packges" warning for python 3.11
export PYDEVD_DISABLE_FILE_VALIDATION=1
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab

# Kitty
if [ $TERM = "xterm-kitty" ]; then
  LIGHT_COLOR='tokyonight_day.conf'
  DARK_COLOR='tokyonight_moon.conf'

  alias tday="cp ~/.config/kitty/themes/$LIGHT_COLOR ~/.config/kitty/theme.conf"
  alias tnight="cp ~/.config/kitty/themes/$DARK_COLOR ~/.config/kitty/theme.conf"

  alias icat="kitty +kitten icat"
  alias ssh="kitty +kitten ssh"
  alias kd="kitty +kitten diff"
  alias hrg="kitty + kitten hyperlinked_grep"
  alias ktheme="kitty +kitten themes"
fi


# Alacritty colors
if [ $TERM = "alacritty" ]; then
  LIGHT_COLOR='alacritty_tokyonight_day.yml'
  DARK_COLOR='alacritty_tokyonight_storm.yml'

  alias tday="alacritty-colorscheme apply $LIGHT_COLOR"
  alias tnight="alacritty-colorscheme apply $DARK_COLOR"
  alias ttoggle="alacritty-colorscheme toggle $LIGHT_COLOR $DARK_COLOR"
fi

setopt CORRECT_ALL


# mkdir and cd at once
function mkcd() {
  mkdir -p "$1" && cd "$1";
}
# Same but with z/zoxide/whatever autojump util
function mkz() {
  mkdir -p "$1" && z "$1";
}
# View csv with less and column tools
function csview {
  column -s, -t "$@" | less -N -S
}
# Go to notes and open nvim
export ZK_NOTEBOOK_DIR="/home/vandal/notes"
function znv() {
  if [[ $(basename "$(pwd)") != "notes" ]]; then
    z $ZK_NOTEBOOK_DIR
  fi
  nvim
}


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

JWST_TOKEN_FILE=~/repos/astro/jwst-manage-data/latest_token.txt
if [[ -f "$JWST_TOKEN_FILE" ]]; then
  export MAST_API_TOKEN="$(cat $JWST_TOKEN_FILE)"
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

if command -v zoxide 1>/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

alias luamake=/home/vandal/programs/lua-language-server/3rd/luamake/luamake

# Conda init stuff slows down shell. Load only when used (not my main Python)
# Tiny delay from conda init would be OK if used mamba as main Python.
alias mambaload="eval \"\$(/home/vandal/mambaforge/bin/conda shell.zsh hook)\""

# Enable intel oneapi compilers (not python)
alias isource="source /opt/intel/oneapi/setvars.sh --config=\"/home/vandal/.zsh/intel_oneapi_config.txt\""

alias apero_source_setup="source /home/vandal/apero/default/apero/apero.zsh.setup"
