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

# automatically run 'ls' after every directory change
# automatically run 'git status' if in a git repository
function chpwd() {
    emulate -L zsh
	if $(git rev-parse --is-inside-work-tree 2>/dev/null)
	then
		git status
	fi
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

function ncs() {
	ncmpcpp --screen search_engine
}

function t() {
	zsh
}

function q() {
	if [ $# -gt 0 ]
	then
		qalc -t "$*"
	else
		qalc
	fi
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
	nvim +2 $LATEX_DIR/latex_input.tex
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
	ipython ~/.ipython_sympy.py -i --no-banner --no-confirm-exit
}

#set up notes environment
function notes() {
	if [ $# -eq 0 ]
	then
		DATE="$(date "+%Y-%m-%d")"
		FOLDER="$DATE"
		FILENAME="notes.tex"
	else
		FOLDER="$*"
		FILENAME="$*.tex"
	fi
	index=0
	while [ -d "$FOLDER" ]; do
		printf -v FOLDER -- '%s_%01d' "$FOLDER" "$((++index))"
	done
	mkdir $FOLDER
	cd $FOLDER
	cp ~/.vim/templates/notes.tex "./$FILENAME"
	cp ~/.vim/templates/latexmkrc .
	sed -i "s/DATE/$(date "+%B %-d, %Y")/g" "./$FILENAME"
	SUBJECT=$(basename "$(dirname "$(dirname "$(pwd)")")" | sed -e "s/\([a-zA-Z]\)\([0-9]\)/\1 \2/g")
	SUBJECT=${SUBJECT:u}
	TYPE=$(basename "$(dirname "$(pwd)")")
	TYPE=${TYPE:u}
	case $TYPE in
		HOMEWORK)
			TYPE="Homework $(basename "$(pwd)" | sed "s/[^0-9]//g")"
			;;
		NOTE*)
			TYPE="Notes"
			;;
		LAB*)
			TYPE="Lab $(basename "$(pwd)" | sed "s/[^0-9]//g")"
			;;
		QUIZ*)
			TYPE="Quiz $(basename "$(pwd)" | sed "s/[^0-9]//g")"
			;;
		EXAM*)
			TYPE="Exam $(basename "$(pwd)" | sed "s/[^0-9]//g")"
			;;
		*)
			TYPE=${(C)TYPE}
			;;
	esac
	sed -i "s/TITLE/$SUBJECT $TYPE/g" "./$FILENAME"
	nvim +'$-2' +VimtexCompile "./$FILENAME"
}

#search pdf notes
function notesearch() {
	if [ $# -gt 0 ]
	then
		pdfgrep -Ri $* --color "always" --cache | sort -h
	fi
}

#open todo
function td() {
	nvim ~/.vimwiki/wiki/TODO.wiki +0
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

# vsync function
function vsync() {
	nvidia-settings --assign CurrentMetaMode="nvidia-auto-select @1920x1080 +0+0 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0, ForceFullCompositionPipeline = $1}, DPY-2:
	nvidia-auto-select @1920x1080 +1920+0 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0, ForceFullCompositionPipeline = $2}"
}

function gamer() {
	if [ $# -eq 0 ]
	then
		vsync on off
		pkill xcompmgr
	else
		vsync on on
		xcompmgr &disown
	fi
}

function ff() {
	firefox $*
}

function clip() {
	head -c -1 | xclip -selection clipboard
}

function jpc() {
	jupyter console --existing --ZMQTerminalInteractiveShell.banner= --ZMQTerminalInteractiveShell.image_handler=None --no-confirm-exit
}

#	Aliases
alias l="ls -lAh"
#Prevents accidental running of ghostscript command
alias gs="git status"
alias glr="git pull --rebase"
alias gadp="git add -p"
alias se="sudo -e"
alias igrep="grep -i"
alias isv='if [[ $VIMRUNTIME != "" ]]; then; echo "Vim session found"; else; echo "No Vim session found"; fi;'
alias bgd="bg && disown"
alias ds="find . -maxdepth 1 -exec du -sh '{}' \; | sort -h | grep -vP '^[^\s]+\s\.$'"
alias j="jump"
alias za="zathura"
alias v="nvim"
alias vim="nvim"
alias de="disown && exit"
alias truestudio="/opt/truestudio/ide/TrueSTUDIO"
alias R="R --quiet"
alias tdir='mkdir $(date "+%Y-%m-%d") && ls'
alias b='time zsh -i -c "exit"'
alias feh="feh --scale-down --auto-zoom --auto-rotate --image-bg \"#000102\""
alias ffprobe='ffprobe -hide_banner'
alias ffmpeg='ffmpeg -hide_banner'
alias lsofstat='lsof | tail -n "+2" | grep -oP "^[^\s]+" | sort | uniq -c | sort -n'
alias bat='bat -p'
alias histo='sort | uniq -c | sort -n'
alias makevars='make -pn | grep -A1 "^# makefile"| grep -v "^#\|^--" | sort | uniq'
alias ns='notesearch'
alias venv='python3 -m venv'
alias rstudio='rstudio-bin'
alias ipython='ipython --no-confirm-exit'
alias op='xdg-open'
alias rstudio='rstudio-bin --no-sandbox'
alias x='exit'
alias .='cd .'
