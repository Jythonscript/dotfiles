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

function cheat() {
	curl cheat.sh/$1
}

#automatically run 'ls' after every directory change
function chpwd() {
    emulate -L zsh
    ls
}

function pdf-merge() {
	env gs -sDEVICE=pdfwrite -sOutputFile=$1 -dNOPAUSE -dBATCH -q ${@:2}
}

# print ^C
TRAPINT() {
  print -n "^C"
  return $(( 128 + $1 ))
}

function n() {
	ncmpcpp
}

function t() {
	zsh
}

#latex popup
#credit to annoyatron255 for this function
function tx() {
	LATEX_DIR=/tmp/latex_temp
	mkdir -p $LATEX_DIR
	if [[ "$*" != *"edit"* ]]
	then
		echo -e "\\\\begin{align*}\n\t\n\\\\end{align*}" > $LATEX_DIR/latex_input.tex
	fi
	vim +2 +"call vimtex#syntax#p#amsmath#load()" $LATEX_DIR/latex_input.tex
	echo -E "${$(<$HOME/.vim/templates/shortdoc.tex)//CONTENTS/$(<$LATEX_DIR/latex_input.tex)}" > $LATEX_DIR/latex.tex
	( cd $LATEX_DIR ; pdflatex $LATEX_DIR/latex.tex )
	pdfcrop --margins 12 $LATEX_DIR/latex.pdf $LATEX_DIR/latex.pdf
	pdf2svg $LATEX_DIR/latex.pdf $LATEX_DIR/latex.svg
	pdftoppm $LATEX_DIR/latex.pdf $LATEX_DIR/latex -png -f 1 -singlefile -rx 600 -ry 600
	if [[ "$*" == *"svg"* ]]
	then
		nohup xclip -selection clipboard -target image/x-inkscape-svg -i $LATEX_DIR/latex.svg 1>&- 2>&- 0<&-
	else
		nohup xclip -selection clipboard -target image/png -i $LATEX_DIR/latex.png 1>&- 2>&- 0<&-
	fi
}

#ipython sympy environment
function sym() {
	ipython ~/.ipython_sympy.py -i --no-banner
}

#set up notes environment
function notes() {
    DATE="$(date "+%Y-%m-%d")"

	if [ $# -gt 0 ]; then
		FOLDER="$1"
	else
		FOLDER="$DATE"
	fi
    index=0

    while [ -d "$FOLDER" ]; do
        printf -v FOLDER -- '%s_%01d' "$DATE" "$((++index))"
    done
    mkdir $FOLDER
    cd $FOLDER
    cp ~/.vim/templates/notes.tex ./
    sed -i "s/DATE/$(date "+%B %d, %Y")/g" ./notes.tex
	sed -i "s/TITLE/Lecture Notes/g" notes.tex
    nvim +'$-2' +VimtexCompile ./notes.tex
}

#search pdf notes
function notesearch() {
	if [ $# -gt 0 ]
	then
		pdfgrep -ri $* --color "always" | sort -h
	fi
}

#open todo
function td() {
	vim ~/.vimwiki/wiki/TODO.wiki +0
}

#open the current terminal buffer in vim
function vimbuffer() {
	# Paste scrollback to print_file. Terminal specific.
    xdotool key --window $WINDOWID ctrl+Print
    local print_file="/tmp/urxvt_screen"
    local written_file="/tmp/urxvt_buffer.sh"
    local prompt_string="$(print -P "$PS1" | sed 's/\x1b\[[0-9;]*m//g')"

    # Remove trailing newlines
    printf '%s\n' "$(cat "$print_file")" > "$written_file"
    # Remove last lines of buffer
    tail -n $(tac "$written_file" | grep -nm1 "$prompt_string" | cut -d : -f 1) \
        "$written_file" | wc -c | xargs -I {} truncate "$written_file" -s -{}

    local scrollback_line_length=$(( $(wc -l < "$written_file") + 1 ))
    echo "$prompt_string$PREBUFFER$BUFFER" >> "$written_file"

    local byte_offset=$(( ${#PREBUFFER//$'\n'/} + ${#LBUFFER//$'\n'/} + \
        $(printf "%s" "$prompt_string" | wc -m) ))
    vim "+${scrollback_line_length}" "+normal ${byte_offset} " -- \
        "$written_file" </dev/tty

    print -Rz - "$(tail -n $(tac "$written_file" | grep -nm1 "$prompt_string" \
        | cut -d : -f 1) "$written_file" | tail -c +$(( $(printf "%s" \
        "$prompt_string" | wc -c) + 1 )))"

    rm "$written_file"
    zle send-break
}

function manpdf() {
	zathura <(man -Tpdf $*) & disown
}

function vim_session_color() {
	if [[ $VIMRUNTIME != "" ]]; then
		print -P "%F{51}"
	else
		printf "\$fg[red]"
	fi
}

# credit to annoyatron255 for this function
function shaders() {
    SHADER_PATH="$HOME/git/compton-shaders/"
    if [ $# -eq 0 ]
    then
        SHADER="$(find $SHADER_PATH -type f -iname "*.glsl" | fzf --delimiter / --with-nth -1 | head -n 1)"
    else
        SHADER="$(find $SHADER_PATH -type f -iname "*.glsl" | fzf -f "$*" | head -n 1)"
    fi

    if [[ -n "$SHADER" || $! -eq "0" ]]
    then
        killall picom
        while killall -0 picom
        do
            sleep 1
        done
        picom -b --backend glx --force-win-blend --use-damage --glx-fshader-win "$(cat "$SHADER")"
    fi
}

# optical character recognition function
function ocr() {
	tesseract =(import png:-) - 2> /dev/null | xclip -selection clipboard 1>&- 2>&-
}

#	Environment
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export SAVEHIST=100000
#[ -n "$XTERM_VERSION" ] && transset --id "$WINDOWID" >/dev/null
# spawning a terminal with awesome keeps directory

# profiling for shell benchmarks
zmodload zsh/zprof

#	Aliases
alias l="ls -lAh"
#Prevents accidental running of ghostscript command
alias gs="git status"
alias se="sudo -e"
alias igrep="grep -i"
alias isv='if [[ $VIMRUNTIME != "" ]]; then; echo "Vim session found"; else; echo "No Vim session found"; fi;'
alias bgd="bg && disown"
alias ds="find . -maxdepth 1 -exec du -sh '{}' \; | sort -h | grep -vP '^[^\s]+\s\.$'"
alias j="jump"
alias za="zathura"
alias v="nvim"
alias vim="echo bad && sleep 1 && nvim"
alias de="disown && exit"
alias truestudio="/opt/truestudio/ide/TrueSTUDIO"
alias R="R --quiet"
alias tdir='mkdir $(date "+%Y-%m-%d") && ls'
alias b='time zsh -i -c "exit"'
alias feh="feh --scale-down --auto-zoom --auto-rotate --image-bg \"#000102\""
alias ffprobe='ffprobe -hide_banner'
alias ffmpeg='ffmpeg -hide_banner'

# ZLE keybindings
zle -N vimbuffer
bindkey '^P' vimbuffer
bindkey "" backward-kill-word
bindkey -s " " " "

#	Other
#used in awesomewm open terminal in same directory script
mkdir -p /run/user/$(id --user)/urxvtc_ids/
echo $$ > /run/user/$(id --user)/urxvtc_ids/$WINDOWID
#Disable ctrl+s freeze terminal
stty -ixon
#Custom paths
export PATH="$PATH:/home/avery/usr/local/bin"
export PROMPT="${PROMPT//\$fg\[red\]/$(vim_session_color)}"
