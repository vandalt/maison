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

# Put extra completions in zfunc
fpath+=~/.zfunc

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

#source ~/programs/powerlevel10k/powerlevel10k.zsh-theme
#source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
#source /usr/share/fzf/shell/key-bindings.zsh
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
alias ltr='ls -ltr'
alias rmr='rm -rI'
alias dh='du -sch *'
alias dha='du -d 1 -h .'
alias untar='tar -xvf'
alias guntar='tar -xzvf'
alias buntar='tar -xjvf'
alias open='xdg-open'
alias ...="cd ../.."
alias gof="open ."

alias t='task'

# Mutt
alias mutt='neomutt'

# Mathematica wayland
alias mathematica='QT_QPA_PLATFORM=xcb mathematica'

# Clone and update AUR in aur dir
alias auracle='auracle -C ~/aur'

# Editor
alias v='nvim'
alias vim='nvim'
# To enable reverse search with synctex by double-clicking PDF
alias vimtex='NVIM_LISTEN_ADDRESS=/tmp/texsocket nvim'
alias code='code --enable-features=UseOzonePlatform --ozone-platform=wayland'

# Notifications in sway
# NOTE: No "toggle" for mako modes yet (https://github.com/emersion/mako/pull/382)
alias dnd='makoctl set-mode do-not-disturb'
alias dndoff='makoctl set-mode default'

# Quick access to config files
alias cnvim='nvim ~/.config/nvim/init.lua'
alias csway='nvim ~/.config/sway/config'
alias zshrc='nvim ~/.zshrc'

setopt +o nomatch
alias texclean='rm *.aux *.fls *.fdb_latexmk *.log *.out *.vrb *.nav *.snm *.synctex.* *.toc'

export THEANO_FLAGS=blas__ldflags="-L/usr/lib/ -lopenblas"
export WEBBPSF_PATH=$HOME/Documents/jwst/data/webbpsf-data
export PYSYN_CDBS=$HOME/Documents/jwst/data/trds

# Kitty
if [ $TERM = "xterm-kitty" ]; then
  LIGHT_COLOR='tokyonight_day.conf'
  DARK_COLOR='tokyonight_storm.conf'

  alias tday="cp ~/.config/kitty/themes/$LIGHT_COLOR ~/.config/kitty/theme.conf"
  alias tnight="cp ~/.config/kitty/themes/$DARK_COLOR ~/.config/kitty/theme.conf"

  alias icat="kitty +kitten icat"
  alias ssh="kitty +kitten ssh"
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



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

if command -v zoxide 1>/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

alias luamake=/home/vandal/programs/lua-language-server/3rd/luamake/luamake
