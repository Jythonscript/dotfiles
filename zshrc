# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/avery/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="daveverwer"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
source ~/.zvm.zsh

plugins=(
  git
  history
  #z
  zsh-syntax-highlighting
  jump
  timer
  colored-man-pages
  fzf
  zsh-vi-mode
  terraform
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#export PATH=$HOME/brew/bin:$PATH

function source_if_exists() {
	if [[ -f $1 ]]; then
		source $1
	fi
}

#	Environment
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESS="-j4 -iR"
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export FZF_TMUX_HEIGHT='15%'
export FZF_CTRL_R_OPTS='--min-height=5'
#[ -n "$XTERM_VERSION" ] && transset --id "$WINDOWID" >/dev/null
# spawning a terminal with awesome keeps directory

# profiling for shell benchmarks
zmodload zsh/zprof

# ZLE keybindings
zle -N vimbuffer
bindkey '^P' vimbuffer
bindkey "^H" backward-kill-word
bindkey -s "^[ " " "
bindkey -r "^[l"

# ZSH styles
zstyle ':completion:*:git-add:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:git-add:*' group-name ''

#	Other
#used in awesomewm open terminal in same directory script
# if [ -n "$WINDOWID" ]; then
# 	mkdir -p /run/user/$(id --user)/urxvtc_ids/
# 	echo $$ > /run/user/$(id --user)/urxvtc_ids/$WINDOWID
# fi

#Disable ctrl+s freeze terminal
stty -ixon
#Custom paths
export PATH="$PATH:/home/avery/usr/local/bin:/home/avery/.local/bin"
#export PROMPT="${PROMPT//\$fg\[red\]/$(vim_session_color)}"

autoload -U compinit; compinit

source_if_exists ~/.extra1.zsh
source ~/.func.zsh
source_if_exists ~/.extra2.zsh
