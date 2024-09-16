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
	env gs -sDEVICE=pdfwrite -sOutputFile=$1 -dNOPAUSE -dBATCH -q ${@:2} -c "[ /Title () /DOCINFO pdfmark" -f
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

function ved() {
	TMPFILE=$(mktemp)
	if [[ $# -eq 0 ]]; then
		xclip -out -selection clipboard > $TMPFILE
	fi
	nvim $TMPFILE
	nohup xclip -in -selection clipboard -rmlastnl 1>&- 2>&- 0<&- < $TMPFILE
	rm $TMPFILE
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
	rga --sort path --type pdf "$*"
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

rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
	FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
		fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
		--phony -q "$1" \
		--bind "change:reload:$RG_PREFIX {q}" \
		--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

rgai-fzf() {
	RG_PREFIX="rga --files-with-matches --rga-adapters=+tesseract"
	local file
	file="$(
	FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
		fzf --sort --preview="[[ ! -z {} ]] && rga --rga-adapters=+tesseract --pretty --context 5 {q} {}" \
		--phony -q "$1" \
		--bind "change:reload:$RG_PREFIX {q}" \
		--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
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

function vsync() {
	xrandr --output DisplayPort-0 --set TearFree $1
	xrandr --output DisplayPort-1 --set TearFree $2
}

function gamer() {
	if [ $# -eq 0 ]
	then
		vsync on off
		pkill picom
		pgrep mygestures && pkill mygestures
	else
		vsync on on
		picom &disown
		pgrep mygestures
		if [ $? -ne 0 ]
		then
			mygestures --device 'Virtual core pointer' --without-brush
		fi
	fi
}

function ff() {
	firefox $*
}

function clip() {
	xclip -selection clipboard -rmlastnl
}

function jpc() {
	jupyter console --existing --ZMQTerminalInteractiveShell.banner= --ZMQTerminalInteractiveShell.image_handler=None --no-confirm-exit
}

function tw() {
	local CHANNELS="canteven msushi m1a2d3i4n5 wirtual distortion2 gamesdonequick zfg1 az_axe waezone slipperynip maltemller blue_sr_ skurrypls moistcr1tikal maciejay btssmash btssmash2 btssmash3 btssmash4 armadaugs muty71 zweek zach777 zachruns unity_b lilstressball klooger plup hungrybox portal2speedruns zainnaghmi racehans fastfox73 mew2king spammiej ssbmhax rattlery zoasty pewpewu"

	local QUALITY="best"

	while getopts ":q:" o; do
		case "${o}" in
			q)
				QUALITY=$OPTARG
				shift 2
				;;
			:)
				echo "Error: -${OPTARG} requires an argument"
				return
				;;
		esac
	done

	if [ $# -gt 0 ]
	then
		case $1 in
			http*)
				local CHANNEL=$(echo $1 | grep -oP "\w+$")
				local TITLE
				if [ $# -gt 1 ]; then
					TITLE="$2"
				else
					TITLE=$(curl $1 | grep -oP '<[^<>]+property="og:description"[^<>]+>' | grep -oP 'content="\K([^"]+)')
				fi
				echo "Quality: $QUALITY"
				streamlink --player mpv --title "$TITLE" --twitch-disable-ads --twitch-low-latency $1 $QUALITY &
				chromium --new-window "https://www.twitch.tv/popout/$CHANNEL/chat?popout="
				;;
			*)
				if [ $# -gt 1 ]; then
					tw -q $QUALITY "https://www.twitch.tv/$1" $2
				else
					tw -q $QUALITY "https://www.twitch.tv/$1"
				fi
				;;
		esac
	else
		local OUTPUT=$(echo $CHANNELS | tr ' ' '\n' | \
			parallel 'OUT=$(curl https://www.twitch.tv/{} 2>/dev/null) \
			&& echo $OUT | grep isLiveBroadcast > /dev/null \
			&& TITLE=$(echo $OUT | grep -oP '"'"'<[^<>]+property="og:description"[^<>]+>'"'"' | \
				grep -oP '"'"'content="\K([^"]+)'"'"') \
			&& printf "%-17s %s\n" {} $TITLE' | fzf)
		local CHANNEL=$(echo $OUTPUT | grep -oP "^([\w]+)")
		local TITLE=$(echo $OUTPUT | grep -oP "^[\w]+\s+\K(.*$)")
		if [ "$CHANNEL" = "" ]; then
			echo "No channel selected"
		else
			tw -q "$QUALITY" "$CHANNEL" "$TITLE"
		fi
	fi
}

function dsc() {
	if [ $# -gt 0 ]
	then
		local URL=$(echo $1 | sed -e "s/^https/discord/g")
		discord --url -- $URL
	else
		discord
	fi
}

function tdir() {
	DSTR=""
	if [ $# -gt 0 ]
	then
		DSTR=$(date "+%Y-%m-%d_$1")
	else
		DSTR=$(date "+%Y-%m-%d")
	fi
	mkdir $DSTR && cd $DSTR && pwd
}

function carbonyl() {
	podman run -ti --rm fathyb/carbonyl $*
}

function b() {
	if [[ $# -eq 0 ]]; then
		ddcutil getvcp 10 -d 1
		ddcutil getvcp 10 -d 2
	elif [[ $# -eq 1 ]]; then
		ddcutil setvcp 10 $1 -d 1
		ddcutil setvcp 10 $1 -d 2
	else
		ddcutil setvcp 10 $1 -d 1
		ddcutil setvcp 10 $2 -d 2
	fi
}

function freq() {
	if [[ $# -gt 0 && $1 -eq "off" ]]; then
		sudo cpupower frequency-set -g performance
	else
		sudo cpupower frequency-set -g schedutil
	fi
}

#	Aliases
alias l="ls -lAh"
alias la="ls -lah"
alias lt="ls -lAthr"
#Prevents accidental running of ghostscript command
alias gs="git status"
alias glr="git pull --rebase"
alias gadp="git add -p"
alias gsmu="git submodule update --init --recursive"
alias gdc="git --no-pager diff --compact-summary"
alias gdcs="git --no-pager diff --compact-summary --staged"
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
alias bench='time zsh -i -c "exit"'
alias feh="feh --scale-down --auto-zoom --auto-rotate --auto-reload"
alias ffprobe='ffprobe -hide_banner'
alias ffmpeg='ffmpeg -hide_banner'
alias ffmpeg-vaapi='ffmpeg -hide_banner -hwaccel vaapi -hwaccel_output_format vaapi'
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
alias rgai='rga --rga-adapters=+tesseract -j$(($(nproc) / 2))'
alias .='cd .'
alias bt='bsdtar'
alias nc='ncat'
alias noa='setarch x86_64 -R'
alias beep='mpv --really-quiet --keep-open=no ~/sync/beep.wav'
alias watch='watch -n1'
alias xxd='xxd -R never'
alias ncdu='ncdu --color dark'
