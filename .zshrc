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
# DISABLE_AUTO_UPDATE="true"

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
plugins=(
  git
  history
  z
  zsh-syntax-highlighting
  jump
  timer
  colored-man-pages
  fzf
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

#function yta() {
    #mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
#}


#	Music functions
function yta() {
    #PLAYLIST=~/.config/mpd/playlists/yt-playlist.m3u
    PLAYLIST=~/Music/Playlists/yt-playlist.m3u

    printf "#EXTM3U\n#EXTINF:" > $PLAYLIST

    youtube-dl -f bestaudio -j ytsearch:"$*" | jq -cMr .duration | tr '\n' ',' >> $PLAYLIST
    youtube-dl -f bestaudio --get-title ytsearch:"$*" >> $PLAYLIST
    youtube-dl -f bestaudio -g ytsearch:"$*" >> $PLAYLIST

    mpc load $(basename -s .m3u $PLAYLIST)
}

function ytao() {
	    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}

function ytaa() {
    PLAYLIST=~/Music/Playlists/yt-playlist.m3u

    #printf "#EXTM3U\n#EXTINF:" > $PLAYLIST
	printf "" > $PLAYLIST

    youtube-dl -f bestaudio -g ytsearch:"$*" >> $PLAYLIST

    mpc load $(basename -s .m3u $PLAYLIST)
}

function yt() {
    mpv ytdl://ytsearch:"$*"
}

function m() {
	if [ $# -eq 0 ]
	then
		TRACK="$(mpc listall -f "%file%\t%title%\t%artist%\t%album%" | fzf | head -n 1 | sed "s/\t.*//")"
	else
		TRACK="$(mpc listall -f "%file%\t%title%\t%artist%\t%album%" | fzf -f "$*" | head -n 1 | sed "s/\t.*//")"
	fi

	# exit if no track selected
	if [[ $TRACK == "" ]]
	then
		return
	fi

	mpc add "$TRACK"
}

function mp() {
	if [ $# -eq 0 ]
	then
		TRACK="$(mpc listall -f "%file%\t%title%\t%artist%\t%album%" | fzf | head -n 1 | sed "s/\t.*//")"
	else
		TRACK="$(mpc listall -f "%file%\t%title%\t%artist%\t%album%" | fzf -f "$*" | head -n 1 | sed "s/\t.*//")"
	fi

	# exit if no track selected
	if [[ $TRACK == "" ]]
	then
		return
	fi

    if $(mpc playlist -f "%file%" | grep -Fxq "$TRACK")
    then
        mpc play $(mpc playlist -f "%file%" | grep -nFx "$TRACK" | sed "s/:.*//" | head -n 1)
    else
        mpc add "$TRACK"
        mpc play $(mpc playlist | wc -l)
    fi
}

#	Convenience functions
function search() {
	echo $PATH | tr ':' '\n' | xargs -I{} find '{}' -iname $1
}

#automatically run 'ls' after every directory change
function chpwd() {
    emulate -L zsh
    ls
}

function nc() {
	ncmpcpp
}

#	Environment
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export SAVEHIST=100000
#[ -n "$XTERM_VERSION" ] && transset --id "$WINDOWID" >/dev/null
# spawning a terminal with awesome keeps directory

#	Aliases
alias l="ls -lAh"
#Prevents accidental running of ghostscript command
alias gs="git status"
alias se="sudoedit"
alias igrep="grep -i"
alias isv='if [[ $VIMRUNTIME != "" ]]; then; echo "Vim session found"; else; echo "No Vim session found"; fi;'
alias bgd="bg && disown"
alias ds="find . -maxdepth 1 -exec du -sh '{}' \; | sort -h | grep -vP '^[^\s]+\s\.$'"
alias j="jump"
alias za="zathura"
alias v="vim"
alias de="disown && exit"
alias truestudio="/opt/truestudio/ide/TrueSTUDIO"
alias R="R --quiet"
alias tdir="mkdir $(date "+%Y-%m-%d") && ls"

# ZLE keybindings
bindkey "" backward-kill-word

#	Other
#used in awesomewm open terminal in same directory script
mkdir -p /run/user/$(id --user)/urxvtc_ids/
echo $$ > /run/user/$(id --user)/urxvtc_ids/$WINDOWID
#Custom paths
export PATH="$PATH:/home/avery/usr/local/bin"
#Disable ctrl+s freeze terminal
stty -ixon
compinit
