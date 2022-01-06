# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
  PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$PATH"
fi

# Put extra completions in zfunc
fpath+=~/.zfunc

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

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

# Must be after vi/emacs mode
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
alias ltr='ls -ltr'
alias dh='du -sch *'
alias dha='du -d 1 -h .'
alias untar='tar -xvf'
alias guntar='tar -xzvf'
alias buntar='tar -xjvf'
alias open='xdg-open'
alias ...="cd ../.."

# Clone and update AUR in aur dir
alias auracle='auracle -C ~/aur'

# Editor
alias vim='nvim'
alias code='code --enable-features=UseOzonePlatform --ozone-platform=wayland'

# Python
alias p='ipython'
# enable shared libraries (requied for some packages like theano)
alias spyenv='env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv'
alias pup='python -m pip install -U pip'

# Notifications in sway
# NOTE: No "toggle" for mako modes yet (https://github.com/emersion/mako/pull/382)
alias dnd='makoctl set-mode do-not-disturb'
alias dndoff='makoctl set-mode default'

# Quick access to config files
alias cnvim='nvim ~/.config/nvim/init.lua'
alias csway='nvim ~/.config/sway/config'
alias zshrc='nvim ~/.zshrc'

export THEANO_FLAGS=blas__ldflags="-L/usr/lib/ -lopenblas"
export WEBBPSF_PATH=$HOME/Documents/jwst_data/webbpsf-data

# Kitty
if [ $TERM = "xterm-kitty" ]; then
    alias icat="kitty +kitten icat"
    alias ssh="kitty +kitten ssh"
fi


# Alacritty colors
if [ $TERM = "alacritty" ]; then
  LIGHT_COLOR='gruvbox_light.yml'
  DARK_COLOR='gruvbox_dark.yml'

  alias aday="alacritty-colorscheme apply $LIGHT_COLOR"
  alias anight="alacritty-colorscheme apply $DARK_COLOR"
  alias atoggle="alacritty-colorscheme toggle $LIGHT_COLOR $DARK_COLOR"
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



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

if command -v zoxide 1>/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi
